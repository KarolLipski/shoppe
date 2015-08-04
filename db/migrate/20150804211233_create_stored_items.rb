class CreateStoredItems < ActiveRecord::Migration
  def change
    create_table :stored_items do |t|
      t.references :magazine, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :price , precision: 10 , scale: 2

      t.timestamps null: false
    end
  end
end
