class AddNoguestToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :noguest, :integer
  end
end
