class OrdersController < ApplicationController
  include CartsHelper

  # POST create order
  def create
    @user, @cart  = current_user, current_cart
    result = CreateOrderService.new(@cart, @user, params[:quantities]).call
    @items = @cart.cart_items
    if(result[:success])
      flash[result[:info][:type]] = result[:info][:message]
      redirect_to cart_show_path
    else
      flash.now[result[:info][:type]] = result[:info][:message]
      render 'carts/show'
    end
  end

end
