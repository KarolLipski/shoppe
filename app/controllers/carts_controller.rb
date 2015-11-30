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

  #POST cart/add_item
  #adds item to cart
  def add_item
    @cart = current_cart
    if @cart.nil?
      @errors = ['Zaloguj sie aby móc dodawać do koszyka.']
    else
      @cart_item = CartItem.where(item_id: params[:item_id],cart: @cart).first_or_initialize
      @cart_item.quantity = params[:quantity]
      @errors = @cart_item.errors.full_messages unless @cart_item.save
    end
    render :save
  end

  #GET cart/show
  #displays cart items
  def show
    @cart = current_cart
    @items = @cart.cart_items
  end

end
