class TagTopic < ApplicationRecord
  has_many(
    :tagging,
    primary_key: :id, foreign_key: :top_id, class_name: "Tagging"
  )

  has_many(
    :urls, through: :tagging, source: :link
  )

  def popular_links
    shortened_urls.joins(:visits)
    .group(:long_url)
    .order('COUNT(visits.id) DESC')
    .select('long_url, short_url, COUNT(visits.id) AS number_of_visits')
    .limit(5)

  end

end
