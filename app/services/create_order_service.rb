class CreateOrderService

  attr_reader :cart, :user

  def initialize(cart, user)
    @cart = cart
    @user = user
  end

  def call
    order , price , all_valid  = create_order, 0, true
    @cart.cart_items.each do |cart_item|
      all_valid = false unless cart_item.valid?
      if cart_item.quantity > 0 && all_valid
        order_item = add_oder_item(cart_item,order)
        price += order_item.total_price
      end
    end
    order.price = price
    order.save if order.order_items.size > 0
    flash = generate_flash(order)
    return {success: order.persisted? , order: order, info: flash}
  end

  def create_order
    Order.new(user: @user)
  end

  def generate_flash(order)
    if order.order_items.size == 0
      return {:type => :warning, :message => 'Brak towarów do zamówienia'}
    end
    if order.persisted?
      return {:type => :success, :message => 'Zamówienie zostało złożone'}
    else
      return {:type => :danger, :message => 'Niektóre towary zawierają błedy'}
    end
  end

  def add_oder_item(cart_item,order)
    total_price = (cart_item.quantity * cart_item.item.price)
    order_item = OrderItem.new(order: order, item: cart_item.item,
       quantity: cart_item.quantity, price: cart_item.item.price,
       total_price: total_price
    )
    order.order_items << order_item
    order_item
  end

end