class CartItemsController < ApplicationController
  before_action :set_product, :set_cart

  def create
    @cart.cart_items.create!(product: @product)
    redirect_to product_url(@product)
  end

  def destroy
  end

private
  def set_product
    @product = Product.find(params[:product_id])
  end
  def set_cart
    @cart = current_user.cart
  end
end
