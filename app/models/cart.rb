class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def amount
    # products = cart_items.map( &:product )
    # products.map( &:price ).inject(0, :+)
    #
    amount = 0
    cart_items.each do |cart_item|
      amount += cart_item.quantity * cart_item.product.price
    end
    amount
  end

  def items_count
    cart_items.map( &:quantity ).inject(0, :+)
  end
end
