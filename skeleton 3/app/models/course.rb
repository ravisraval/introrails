class Course < ActiveRecord::Base
  has_many :enrollments, primary_key: :id, foreign_key: :course_id,
  class_name: "Enrollment"

  belongs_to :prereq, primary_key: :id, foreign_key: :prereq_id, class_name: "Course" #if course has a prereq

  belongs_to :teacher, primary_key: :id, foreign_key: :instructor_id, class_name: "User"
end
