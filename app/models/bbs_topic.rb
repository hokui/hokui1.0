class BbsTopic < ActiveRecord::Base
  has_many :bbs_bodies
  has_one :subject
  belongs_to :bbs_group
  belongs_to :user
end
