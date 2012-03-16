class ChangeUser < ActiveRecord::Migration
  def change
    add_column :users, :birthyear, :integer
    add_column :users, :birthmonth, :integer
    add_column :users, :authority, :string
  end
end
