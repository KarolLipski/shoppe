class ChangeItemToStoredItemInOrderItems < ActiveRecord::Migration
  def change
    remove_foreign_key :order_items, :items
    remove_column :order_items, :item_id
    add_column :order_items, :stored_item_id, :integer, references: :stored_items
  end
end
