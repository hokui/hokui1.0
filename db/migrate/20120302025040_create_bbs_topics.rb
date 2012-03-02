class CreateBbsTopics < ActiveRecord::Migration
  def change
    create_table :bbs_topics do |t|
      t.integer :bbs_group_id
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
