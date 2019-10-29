class CartsController < ApplicationController
  before_action :set_cart

  def show
    @order = Order.new
  end

private
  def set_cart
    @cart = current_user.cart
  end
end
