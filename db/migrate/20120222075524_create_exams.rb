class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :year, null: false
      t.boolean :type, null: false
      t.binary :file, null: false
      t.string :content_type, null: false
      t.string :file_name, null: false

      t.timestamps
    end

    add_index :exams, :file, unique: true
  end
end
