class AddTextbooksToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :textbooks, :string
  end
end
