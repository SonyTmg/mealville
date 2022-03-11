class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :for_user, null: false, foreign_key: { to_table: :users }
      t.references :by_user, null: false, foreign_key: { to_table: :users }
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
