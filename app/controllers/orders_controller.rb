class OrdersController < ApplicationController
  before_action :set_cart, only: %i[create]

  def create
    order = Order.new(order_params)
    order.build_items_from(@cart)

    if order.save
      redirect_to root_url, notice: '購入ありがとうございました！'
    else
      redirect_to carts_url
    end
  end

  private
  def set_cart
    @cart = current_user.cart
  end
  def order_params
    params.require(:order).permit(:name, :address, :delivery_date)
  end
end
