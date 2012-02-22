class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.string :group, null: false

      t.timestamps
    end

    add_index :subjects, :title, unique: true
  end
end
