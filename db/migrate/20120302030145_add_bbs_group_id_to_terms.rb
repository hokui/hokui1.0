class AddBbsGroupIdToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :bbs_group_id, :integer
  end
end
