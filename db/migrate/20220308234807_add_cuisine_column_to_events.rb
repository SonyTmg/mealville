class AddCuisineColumnToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :cuisine, :string
  end
end
