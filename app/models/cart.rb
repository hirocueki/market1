class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def amount
    cart_items.map( &:amount ).inject(0, :+)
  end

  def items_count
    cart_items.map( &:quantity ).inject(0, :+)
  end
end
