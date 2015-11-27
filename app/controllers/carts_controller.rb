class CartsController < ApplicationController
  include CartsHelper

  #GET init_add/:item_id
  # initialize action before add item to cart
  def init_add
    @cart = current_cart
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.build(cart: @cart, item: @item)
  end
end
