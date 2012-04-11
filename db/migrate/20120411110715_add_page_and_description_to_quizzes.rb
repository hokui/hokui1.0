class AddPageAndDescriptionToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :page, :integer
    add_column :quizzes, :description, :string
  end
end
