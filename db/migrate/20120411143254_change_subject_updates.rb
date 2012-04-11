class ChangeSubjectUpdates < ActiveRecord::Migration
  def up
    add_column :subject_updates, :update_type, :string
    remove_column :subject_updates, :type
  end

  def down
  end
end
