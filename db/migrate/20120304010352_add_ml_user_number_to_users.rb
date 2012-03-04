class AddMlUserNumberToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :ml_user_number
      t.date :birthday
      t.string :mail
    end
  end
end
