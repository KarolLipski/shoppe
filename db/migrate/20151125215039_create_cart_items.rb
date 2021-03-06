class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
