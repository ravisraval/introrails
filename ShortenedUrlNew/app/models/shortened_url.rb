class ShortenedUrl < ApplicationRecord
  validates :user_id, presence: true
  validates :short_url, presence: true,
            uniqueness: { scope: :user_id, message: 'Users can only have one instance of specific URL'}
  validates :long_url, presence: true,
            uniqueness: { scope: :user_id, message: 'Users can only have one instance of specific URL'}

  validate :no_spamming
  validate :nonpremium_max

  belongs_to(
    :submitter, primary_key: :id, foreign_key: :user_id, class_name: "User"
  )

  has_many(
    :visits,
    primary_key: :id, foreign_key: :shortened_url_id, class_name: "Visit"
  )

  has_many(
    :visitors,
    through: :visits, source: :visitor
  )

  has_many(
    :tagging,
    primary_key: :id, foreign_key: :url_id, class_name: "Tagging"
  )

  has_many(
    :tags, through: :tagging, source: :topics
  )


  def self.random_code
    current_code = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(current_code)
      current_code = SecureRandom.urlsafe_base64(16)
    end
    current_code
  end

  def self.create!(user, long_url)
    ShortenedUrl.create(user_id: user.id, short_url: ShortenedUrl.random_code, long_url: long_url)
  end


  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.distinct.count
  end

  def num_recent_uniques
    visits
      .where("created_at > ?", 10.minutes.ago)
      .distinct.count
  end

  def no_spamming
    # SELECT
    #   COUNT(short_url)
    # FROM
    #   shortened_urls
    # WHERE
    #   created_at > ?, 1.minute.ago
    # GROUP BY
    #
    # spam_count = shortened_urls.select("COUNT(short_url)").joins(:)
    # if COUNT(urls accessed by one user within last minute) != 0
    #       errors[:spam] << "don't suck no spamming"
    #     end
  end

  def nonpremium_max
    if discount > total_value
          errors[:discount] << "can't be greater than total value"
        end
  end

end
