class CreateBbsBodies < ActiveRecord::Migration
  def change
    create_table :bbs_bodies do |t|
      t.integer :bbs_topic_id
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
