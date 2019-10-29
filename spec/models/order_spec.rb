require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:today) { Date.today }
  let!(:cart) { FactoryBot.create(:cart) }

  it 'invalid' do
    expect(Order.new).to be_invalid
    expect(Order.new(name:'やまもとじょうじ')).to be_invalid
    expect(Order.new(name:'やまもとじょうじ', address: '東京')).to be_invalid
  end

  it 'valid' do
    # delivery_timeのdefaultが決まるので以下のテストは通る
    expect(Order.new(name:'やまもとじょうじ', address: '東京', delivery_date: Date.today)).to be_valid
    expect(Order.new(name:'やまもとじょうじ', address: '東京', delivery_date: Date.today, delivery_time: :tm8_12)).to be_valid
  end

  it '配達時間はenumerizeされている' do
    is_expected.to enumerize(:delivery_time)
  end

  it '商品が空のオーダーは失敗する' do
    cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
        address: cart.user.address,
        delivery_date: 3.days.ago(today),
        delivery_time: :tm8_12,
        order_items: []
        )
    expect(order.save).to be_falsey
  end

  it '商品を注文する' do
    user = FactoryBot.create(:user, name: 'うえき', address: '山形県')
    user.cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
                     name: user.name,
                     address: user.address,
                     delivery_date: 3.days.ago(today),
                     delivery_time: :tm8_12,
      ) {|order|
      order.build_items_from(user.cart)
      expect(order.save!).to be_truthy
    }
    expect(order).to be_valid
    expect(order.amount).to eq 1000
  end

  it '商品を注文する2' do
    user = FactoryBot.create(:user, name: 'うえき', address: '徳島県')
    user.cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
                     name: user.name,
                     address: user.address,
                     delivery_date: 3.days.ago(today),
                     delivery_time: :tm8_12,
        ) {|order|
      order.build_items_from(user.cart)
    }
    expect(order.order_items).to_not be_empty
    expect{
      order.save!
      # expect( order.save ).to be_truthy
    }.to change{ Order.count }.by(1)
  end

  it '税込価格がただしい' do
    user = FactoryBot.create(:user, name: '田中一郎', address: '沖縄県')
    user.cart.cart_items.create(product: Product.create(name: 'table', price: 1000))

    order = Order.new(
                     name: user.name,
                     address: user.address,
                     delivery_date: 3.days.ago(today),
                     delivery_time: :tm8_12,
                     tax: 10
      ) {|order|
      order.build_items_from(user.cart)
      order.save!
    }
    expect(order.amount_with_tax).to eq 1100

    order.tax = 8
    order.save!

    expect(order.amount_with_tax).to eq 1080
  end

  it '税額8%のときの代引き手数料と送料の計算' do
  # 4,000円で6点の商品を購入したとき5,940円になること
  # 小計 ¥4,000 / 6商品 = ¥4,000 + ¥1,200(¥600x2) + ¥300 = ¥5,500 + 税8% = ¥5,940
  # 税の1円以下は、切り捨て
    order = Order.new(
        name: 'やまもとごろう',
        address: '東京都千代田区２−３',
        delivery_date:  3.days.ago(Date.today),
        tax: 8) {|order|
      order.order_items << [
        OrderItem.new(product: Product.new(name: 'apple', price: 600)),
        OrderItem.new(product: Product.new(name: 'orange', price: 300)),
        OrderItem.new(product: Product.new(name: 'banana', price: 200)),
        OrderItem.new(product: Product.new(name: 'milk', price: 400)),
        OrderItem.new(product: Product.new(name: 'tea', price: 1000)),
        OrderItem.new(product: Product.new(name: 'grape', price: 1500))
      ]
    }
    order.save!

    expect(order.amount).to eq 4000
    expect(order.extra_charges).to eq 300
    expect(order.shipping_charges).to eq 1200
    expect(order.total_with_tax).to eq 5940
  end

  it '税額10%のときの代引き手数料と送料の計算' do
    order = Order.new(
                     name: 'やまもとごろう',
                     address: '東京都千代田区２−３',
                     delivery_date:  3.days.ago(Date.today)
    ) {|order|
      order.order_items << [
        OrderItem.new(
          product: Product.new(name: 'tea', price: 1000),
          quantity: 15
        ),
      ]
    }
    order.save!

    expect(order.amount).to eq 15_000
    expect(order.extra_charges).to eq 400
    expect(order.shipping_charges).to eq 1_800
    expect(order.total).to eq 17_200
    expect(order.total_with_tax).to eq 18_920
  end
end
