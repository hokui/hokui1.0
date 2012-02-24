class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :subject_id, null: false
      t.integer :year, null: false
      t.integer :number, null: false
      t.string :q_a, null: false
      t.binary :file, null: false
      t.string :content_type, null: false
      t.string :file_name, null: false

      t.timestamps
    end

    add_index :exams, :file, unique: true
  end
end
