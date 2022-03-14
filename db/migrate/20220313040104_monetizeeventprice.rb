class Monetizeeventprice < ActiveRecord::Migration[6.1]
  def change
    add_monetize :events, :price, currency: { present: false }
  end
end
