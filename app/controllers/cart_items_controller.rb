class CartItemsController < ApplicationController
  before_action :set_product, :set_cart
  before_action :set_cart_item, only: :destroy

  def create
    cart_item = @cart.cart_items.build(cart_item_params)
    if cart_item.save
      redirect_to product_url(@product), notice: "#{@product.name}を#{cart_item.quantity}点 追加しました"
    else
      redirect_to product_url(@product)
    end
  end

  def destroy
    @cart_item.destroy!
    redirect_to product_url(@product), notice: "#{@product.name}を削除しました"
  end

private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_cart
    @cart = current_user.cart
  end


  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item)
          .permit(:quantity)
          .merge(product: @product)
  end
end
