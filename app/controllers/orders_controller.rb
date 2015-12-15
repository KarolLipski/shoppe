class OrdersController < ApplicationController
  include CartsHelper

  before_action :check_cart

  # POST create order
  def create
    @user, @cart  = current_user, current_cart
    @order = Order.new(order_params)
    @order.user = @user
    @order.price = @order.order_items.inject(0){|sum,order_item| sum += order_item.total_price}
    if @order.save
      flash[:success] = 'Zamówienie zostało złożone'
      redirect_to root_path
    else
      flash.now[:danger] = 'Niektóre towary zawierają błedy'
      render 'new'
    end

  end

  def new
    @user, @cart  = current_user, current_cart
    @order = Order.new(user: @user)
    @cart.cart_items.each do |cart_item|
      @order.order_items.build(item: cart_item.item,
        quantity: cart_item.quantity, price: cart_item.item.price,
        cart_item_id: cart_item.id)
    end
  end

  def order_params
    params.require(:order).permit(order_items_attributes: [:item_id,:quantity,:price, :cart_item_id])
  end


  def check_cart
    if current_cart.nil? || current_user.nil?
      @order = Order.new
      flash.now[:warning] = 'Brak produktów w koszyku'
      render 'new'
    end
  end

end
