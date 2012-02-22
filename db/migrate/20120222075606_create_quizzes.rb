class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :number
      t.boolean :type
      t.binary :file
      t.string :ftype

      t.timestamps
    end
  end
end
