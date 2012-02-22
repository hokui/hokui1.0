class Subject < ActiveRecord::Base
  has_many :exams
  has_many :quizzes
  has_many :summaries
end
