class AddPageAndDescriptionToExams < ActiveRecord::Migration
  def change
    add_column :exams, :page, :integer
    add_column :exams, :description, :string
  end
end
