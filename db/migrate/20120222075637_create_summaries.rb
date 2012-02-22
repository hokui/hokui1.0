class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :number, null: false
      t.binary :file, null: false
      t.string :content_type, null: false
      t.string :file_name, null: false

      t.timestamps
    end

    add_index :summaries, :file, unique: true
  end
end
