class ProductsController < ApplicationController
  before_action :set_product, only: %i(show)

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @cart_item = CartItem.new
  end

private
  def set_product
    @product = Product.find(params[:id])
  end
end
