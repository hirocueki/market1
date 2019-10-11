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

  def amount_with_tax
    amount + (amount*tax/100).to_i
  end

  def total_with_tax
    total + (total*tax/100).to_i
  end

  def items_count
    order_items.map( &:quantity ).inject(0, :+)
  end

  # 代引き手数料
  # 0-10,000円未満（300円）
  # 10,000-30,000円未満 （400円）
  # 30,000-100,000円未満 （600円）
  # 100,000円以上（1,000円）
  def extra_charges
    case amount
    when 0...10_000
      300
    when 10_000...30_000
      400
    when 30_000...100_000
      600
    else 100_000..
      1000
    end
  end

  # 送料(送料は5商品ごとに600円追加する)
  def shipping_charges
    (items_count.to_f/5).ceil * 600
  end

  def total
    amount + extra_charges + shipping_charges
  end
end
