class CartsController < ApplicationController
  include CartsHelper

  before_action :set_cart

  #GET init_add/:item_id
  # initialize action before add item to cart
  def init_add
    @item = Item.find(params[:item_id])
    cart_item = CartItem.where(item_id: @item.id,cart: @cart).first
    @quantity = cart_item.nil? ? '0' : cart_item.quantity
  end

  def set_cart
    @cart = current_cart
  end

end
