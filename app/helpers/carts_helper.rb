module CartsHelper

  def current_cart
    @current_cart ||= initialize_cart
  end

  def cart_size
    return '0' if current_cart.nil?
    current_cart.cart_items.count
  end

  def cart_value
    return '0' if current_cart.nil?
    current_cart.price_sum
  end

  def initialize_cart
    if logged_in?
      cart = Cart.find_by(user_id: current_user.id)
      cart = Cart.create(user: current_user) if cart.nil?
    end
    cart
  end

end
