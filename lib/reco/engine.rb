module Reco
  # Module used for generate reccomendations an widget for current user
  class Engine
    # returns last added items to catalog. It takes limit and
    def self.last_added(limit, sample)
      StoredItem.active.order(created_at: :desc).take(limit).sample(sample)
    end

    def self.reccomend(limit)
      min_id = StoredItem.active.order('items.id asc').first.id
      max_id = StoredItem.active.order('items.id desc').first.id
      ids = Array.new(150) { rand(min_id..max_id) }

      StoredItem.active.where(items: { id: ids }).take(limit)
    end

    def self.bestsellers(limit)
      StoredItem
        .includes(:item)
        .select('stored_items.* ,
          COUNT(order_items.stored_item_id) as order_count')
        .joins('LEFT OUTER JOIN order_items
          ON order_items.stored_item_id = stored_items.id')
        .group('stored_items.id')
        .having('SUM(stored_items.quantity) > 0')
        .order('order_count desc, SUM(stored_items.quantity) desc')
        .take(limit)
    end
  end
end
