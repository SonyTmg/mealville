class AddPriceToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :price, :float
  end
end
