class CartItemsController < ApplicationController
  include CartsHelper

  skip_before_filter :verify_authenticity_token, only: [:update]

  #PUT cart_items.json
  def update
    @cart_item = CartItem.find(params[:id])
    respond_to do |format|
      if @cart_item.update(quantity: params[:quantity])
        format.json do
          render json: { cart_item: @cart_item, cart: @cart_item.cart,
             sum: @cart_item.cart.price_sum, errors: nil}
        end
      else
        format.json do
          render json: { errors: @cart_item.errors.full_messages }
        end
      end
    end
  end

  #DELETE item form cart
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    render :destroy
  end

  #POST cart_items
  def create
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


end
