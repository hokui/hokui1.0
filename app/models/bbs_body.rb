class BbsBody < ActiveRecord::Base
  belongs_to :bbs_topic
  belongs_to :user
end
