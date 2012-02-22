class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :year
      t.boolean :type
      t.binary :file
      t.string :ftype

      t.timestamps
    end
  end
end
