class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :subject_id, null: false
      t.integer :number, null: false
      t.integer :type, null: false
      t.binary :file, null: false
      t.string :content_type, null: false
      t.string :file_name, null: false

      t.timestamps
    end

    add_index :quizzes, :file, unique: true
  end
end
