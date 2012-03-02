class BbsGroup < ActiveRecord::Base
  has_many :bbs_topics
  has_one :term
end
