class OrderItemsController < ApplicationController

  def index
    order = Order.find(params[:order_id])
    @order_items = order.order_items.page(params[:page]).per(20)
  end
end
