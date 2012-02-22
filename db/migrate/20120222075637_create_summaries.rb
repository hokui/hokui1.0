class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :number
      t.binary :file
      t.string :ftype

      t.timestamps
    end
  end
end
