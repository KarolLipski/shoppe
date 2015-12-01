class AddSumToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :price_sum, :decimal, precision: 10, scale: 2, default: 0
  end
end
