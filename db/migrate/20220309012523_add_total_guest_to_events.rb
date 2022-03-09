class AddTotalGuestToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :total_guest, :integer
  end
end
