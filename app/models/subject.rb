class Subject < ActiveRecord::Base
  belongs_to :bbs_topic
  belongs_to :term
  has_many :exams
  has_many :quizzes
  has_many :summaries

=begin
  validates :term_id,
    presence: true,
    format: {with: /^[0-9]+$/}
  validates :title_ja,
    presence: true,
    uniqueness: true
  validates :title_en,
    presence: true,
    uniqueness: true,
    format: {with: /^[a-z_]$/}
  validates :bbs_topic_id,
    presence: true,
    uniqueness: true,
    format: {with: /^[0-9]+$/}
  validates :teacher,
    presence: true
=end
end
