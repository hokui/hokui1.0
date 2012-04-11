class CreateSubjectUpdates < ActiveRecord::Migration
  def change
    create_table :subject_updates do |t|
      t.integer :subject_id
      t.integer :user_id
      t.string :type
      t.string :data_type
      t.integer :file_id

      t.timestamps
    end
  end
end
