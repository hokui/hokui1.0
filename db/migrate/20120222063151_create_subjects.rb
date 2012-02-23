class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :term_id, null: false
      t.string :page_title, null: false
      t.string :screen_title, null: false

      t.timestamps
    end

    add_index :subjects, :page_title, unique: true
    add_index :subjects, :screen_title, unique: true
  end
end
