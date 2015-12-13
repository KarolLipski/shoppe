class OrdersController < ApplicationController
  include CartsHelper

  # POST create order
  def create
    # @user, @cart  = current_user, current_cart
    # result = CreateOrderService.new(@cart, @user, params[:quantities]).call
    # @items = @cart.cart_items
    # if(result[:success])
    #   flash[result[:info][:type]] = result[:info][:message]
    #   redirect_to cart_show_path
    # else
    #   flash.now[result[:info][:type]] = result[:info][:message]
    #   render 'carts/show'
    # end
    @user, @cart  = current_user, current_cart
    @order = Order.new(order_params)
    @order.price = 10
    @order.user = @user
    if @order.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def new
    @user, @cart  = current_user, current_cart
    @order = Order.new(user: @user)
    @cart.cart_items.each do |item|
      total_price = (item.quantity * item.item.price)
      @order.order_items.build(item: item.item,
        quantity: item.quantity, price: item.item.price,
        total_price: total_price)
    end
  end

  def order_params
    params.require(:order).permit(order_items_attributes: [:item_id,:quantity,:price])
  end

end
