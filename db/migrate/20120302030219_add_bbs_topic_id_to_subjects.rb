class AddBbsTopicIdToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :bbs_topic_id, :integer
  end
end
