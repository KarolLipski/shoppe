class OrdersController < ApplicationController
  include CartsHelper

  before_action :check_cart, except: [:index]

  def index
    @user = current_user
    render 'shared/not_logged' if @user.nil?
    @orders = Order.where(user: @user).order('created_at DESC').includes(:order_items).page(params[:page]).per(20)
  end

  # POST create order
  def create
    @user, @cart  = current_user, current_cart
    @order = Order.new(order_params)
    @order.user = @user
    @order.price = @order.order_items.inject(0){|sum,order_item| sum += order_item.total_price}
    if @order.save
      @cart.make_empty
      OrderMailer.order_email(@order).deliver_later
      flash[:success] = 'Zamówienie zostało złożone'
      redirect_to orders_path
    else
      flash.now[:danger] = 'Niektóre towary zawierają błedy'
      render 'new'
    end
  end

  def new
    @user, @cart  = current_user, current_cart
    @order = Order.new(user: @user)
    @cart.cart_items.each do |cart_item|
      @order.order_items.build(stored_item: cart_item.stored_item,
        quantity: cart_item.quantity, price: cart_item.stored_item.sell_price,
        cart_item_id: cart_item.id)
    end
  end

  def order_params
    params.require(:order).permit(order_items_attributes: [:stored_item_id,:quantity,:price, :cart_item_id])
  end


  def check_cart
    if current_cart.nil? || current_user.nil? || current_cart.cart_items.empty?
      @cart = current_cart
      @order = Order.new
      flash.now[:warning] = 'Brak produktów w koszyku'
      render 'new'
    end
  end

end
