class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
