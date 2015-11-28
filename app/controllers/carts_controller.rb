class CartsController < ApplicationController
  include CartsHelper

  #GET init_add/:item_id
  # initialize action before add item to cart
  def init_add
    @cart = current_cart
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.build(cart: @cart, item: @item)
  end

  #POST cart/add_item
  #adds item to cart
  def add_item
    @cart = current_cart
    @cart_item = CartItem.where(item_id: params[:item_id],cart: @cart).first_or_initialize
    @cart_item.quantity = params[:quantity]
    if @cart_item.save
      flash[:success] = 'Towar został dodany do koszyka'
    else
      @errors = @cart_item.errors.full_messages
    end
    render :save
  end

end
