class User < ActiveRecord::Base
  has_many :bbs_topics
  has_many :bbs_bodies
end
