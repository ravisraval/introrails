class User < ActiveRecord::Base

  # has_many :enrolled_courses, through: #

  # belongs_to :course, class_name: "Course"


  has_many :enrollments, primary_key: :id, foreign_key: :student_id, class_name: "Enrollment"
  has_many :enrolled_courses, through: :enrollments, source: :course
end
