class Tagging < ApplicationRecord
  belongs_to(
    :link, primary_key: :id,
     foreign_key: :url_id, class_name: "ShortenedUrl"
  )

  belongs_to(
    :topics, primary_key: :id,
     foreign_key: :top_id, class_name: "TagTopic"
  )

end
