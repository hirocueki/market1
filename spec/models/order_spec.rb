require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:today) { Date.today }
  let!(:cart) { FactoryBot.create(:cart) }

  it '配達時間はenumerizeされている' do
    is_expected.to enumerize(:delivery_time)
  end

  it '商品を注文する' do
    cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
                   address: cart.user.address,
                   delivery_date: 3.days.ago(today),
                   delivery_time: :tm8_12,
      ) {|order|
      order.build_items_from(cart)
      expect(order.save!).to be_truthy
    }
    expect(order).to be_valid
    expect(order.amount).to eq 1000
  end

  it '税込価格がただしい' do
    cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
      address: cart.user.address,
      delivery_date: 3.days.ago(today),
      delivery_time: :tm8_12,
      tax: 10
      ) {|order|
      order.build_items_from(cart)
      order.save!
    }
    expect(order.amount_with_tax).to eq 1100

    order.tax = 8
    order.save!

    expect(order.amount_with_tax).to eq 1080
  end
end
