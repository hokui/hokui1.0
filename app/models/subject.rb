class Subject < ActiveRecord::Base
  belongs_to :bbs_topic
  belongs_to :term
  has_many :exams
  has_many :quizzes
  has_many :summaries
end
