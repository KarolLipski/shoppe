class ChangeItemToStoredItemInCartItems < ActiveRecord::Migration
  def change
    remove_foreign_key :cart_items, :items
    remove_column :cart_items, :item_id
    add_column :cart_items, :stored_item_id, :integer, references: :stored_items, index: true, foreign_key: true

  end
end
