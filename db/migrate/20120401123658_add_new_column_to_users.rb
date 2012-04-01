class AddNewColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :new_column, :int
  end
end
