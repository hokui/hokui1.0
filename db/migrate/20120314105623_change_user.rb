class ChangeUser < ActiveRecord::Migration
  def change
    add_column :users, :authority, :string
    add_column :users, :invited_by, :integer
    add_column :users, :password_digest, :string
    remove_column :users, :ml_user_number
  end
end
