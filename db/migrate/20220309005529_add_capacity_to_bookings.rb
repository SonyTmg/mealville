class AddCapacityToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :capacity, :integer
  end
end
