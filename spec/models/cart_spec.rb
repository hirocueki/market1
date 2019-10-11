require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:user){ FactoryBot.create(:user) }

  it '商品を追加できる' do
    cart = Cart.create(user: user)
    expect(cart).to be_valid
    expect(cart.cart_items.count).to eq 0

    cart.cart_items.create(
      product: Product.create(name: 'table', price: 1000),
    )
    expect(cart.cart_items.count).to eq 1

    expect(cart.amount).to eq 1000
  end

  it 'おなじ商品を２個追加したときの価格がただしい' do
    cart = Cart.create(user: user)

    cart.cart_items.create(
                     quantity: 2,
                     product: Product.create(name: 'table', price: 1000)
    )
    expect(cart.items_count).to eq 2

    expect(cart.amount).to eq 2000
  end
end
