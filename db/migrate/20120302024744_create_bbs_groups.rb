class CreateBbsGroups < ActiveRecord::Migration
  def change
    create_table :bbs_groups do |t|
      t.string :title

      t.timestamps
    end
  end
end
