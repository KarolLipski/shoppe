class OrdersController < ApplicationController
  include CartsHelper

  # POST create order
  def create
    @user, @cart  = current_user, current_cart
    create_result = CreateOrderService.new(@cart, @user).call
    @items = @cart.cart_items
    if(create_result[:success])
      redirect_to cart_show_path
      flash[:success] = 'Zamówienie zostało złożone'
    else
      flash.now[:danger] = 'Niektóre z towarów zawierają błedy'
      render 'carts/show'
    end
  end

end
