class CartsController < ApplicationController
  include CartsHelper

  #GET init_add/:item_id
  # initialize action before add item to cart
  def init_add
    @cart = current_cart
    @item = Item.find(params[:item_id])
    cart_item = CartItem.where(item_id: @item.id,cart: @cart).first
    @quantity = cart_item.nil? ? '0' : cart_item.quantity
  end

  #GET cart/show
  #displays cart items
  def show
    @cart = current_cart
    @items = @cart.cart_items
  end

end
