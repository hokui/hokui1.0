class AddIsATermToBbsGroups < ActiveRecord::Migration
  def change
    add_column :bbs_groups, :is_a_term, :boolean
  end
end
