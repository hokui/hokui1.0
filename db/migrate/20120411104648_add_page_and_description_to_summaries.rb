class AddPageAndDescriptionToSummaries < ActiveRecord::Migration
  def change
    add_column :summaries, :page, :integer
    add_column :summaries, :description, :string
  end
end
