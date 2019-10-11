class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def amount
    quantity * product.price
  end
end
