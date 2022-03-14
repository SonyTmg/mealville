class RemoveTotalGuestFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :total_guest, :integer
  end
end
