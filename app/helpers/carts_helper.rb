module CartsHelper

  def current_cart
    @current_cart ||= initialize_cart
  end

  def initialize_cart
    if logged_in?
      cart = Cart.find_by(user_id: current_user.id)
      cart = Cart.create(user: current_user) if cart.nil?
    end
    cart
  end

end
