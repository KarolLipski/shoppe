module  CirclesHelper

  #Generates value for circle stock level
  def circleValue(big_wrap, quantity)
    (quantity.to_f / (big_wrap*2)) + 0.03
  end

end