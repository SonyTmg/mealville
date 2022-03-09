class AddNoguestToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :noguest, :integer
  end
end
