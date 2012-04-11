class RemoveFileFromExams < ActiveRecord::Migration
  def up
    remove_column :exams, :file
    remove_column :quizzes, :file
    remove_column :summaries, :file
  end

  def down
  end
end
