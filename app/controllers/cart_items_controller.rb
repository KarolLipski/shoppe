class CartItemsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:update]

  def update
    @cart_item = CartItem.find(params[:id])
    respond_to do |format|
      if @cart_item.update(quantity: params[:quantity])
        format.json do
          render json: { cart_item: @cart_item, cart: @cart_item.cart, errors: nil}
        end
      else
        format.json { render json: @cart_item.errors }
      end
    end
  end
end
