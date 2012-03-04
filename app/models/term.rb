class Term < ActiveRecord::Base
  belongs_to :bbs_group
  has_many :subjects
end
