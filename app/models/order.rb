class Order < ApplicationRecord
  extend Enumerize

  has_many :order_items
  enumerize :delivery_time,
            in: { tm8_12: 0, tm12_14: 1, tm14_16: 2, tm16_18: 3, tm18_20: 4, tm20_21: 5 },
            default: :tm8_12

  def build_items_from(cart)
    cart.cart_items.map do |cart_item|
      order_items.build(
        quantity: cart_item.quantity,
        product: cart_item.product,
        )
    end
  end

  def amount
    order_items.map( &:amount ).inject(0, :+)
  end
end
