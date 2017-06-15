class ShortenedUrl < ApplicationRecord
  validates :user_id, presence: true
  validates :short_url, presence: true,
            uniqueness: { scope: :user_id, message: 'Users can only have one instance of specific URL'}
  validates :long_url, presence: true,
            uniqueness: { scope: :user_id, message: 'Users can only have one instance of specific URL'}

  belongs_to(
    :requester, primary_key: :id, foreign_key: :user_id, class_name: "User"
  )          
end
