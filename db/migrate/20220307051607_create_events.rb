class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :location
      t.time :start_time
      t.time :end_time
      t.integer :capacity
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
