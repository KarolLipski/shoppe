class AddBarCodeToItem < ActiveRecord::Migration
  def change
    add_column :items, :barcode, :string , limit: 13
  end
end
