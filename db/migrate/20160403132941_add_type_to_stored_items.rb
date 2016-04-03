class AddTypeToStoredItems < ActiveRecord::Migration
  def change
    add_column :stored_items, :type, :string
    add_reference :stored_items, :offer, index: true, foreign_key: true
  end
end
