class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :number, null: false
      t.binary :file, null: false
      t.string :ftype, null: false

      t.timestamps
    end

    add_index :summaries, :file, unique: true
  end
end
