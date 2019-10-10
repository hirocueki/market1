require 'rails_helper'

RSpec.describe Product, type: :model do
  it '商品の項目の確認(商品名, 商品画像, 価格（業者を超えても同一価格）,説明文, 非表示フラグ,表示順)' do
    product = Product.create(
                       name: '机',
                       image: '',
                       price: 6000,
                       description: 'ありふれたデザインの机',
                       displayed: true,
                       order_index: 1
    )
    expect(product).to be_valid
  end
end
