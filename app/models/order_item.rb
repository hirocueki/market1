class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def amount
    quantity * product.price
  end
end
