require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザ登録できる' do
    visit new_user_registration_path

    expect {
      fill_in 'Email', with: 'ueki@rails.com'
      fill_in 'Password', with: 'ueki999'
      fill_in 'Password confirmation', with: 'ueki999'
      click_on 'Sign up'
    }.to change{User.count}.by(1)
  end


  let!(:user) { FactoryBot.create(:user) }
  let!(:product) { FactoryBot.create(:product) }

  it 'ログイン後、カートの中身が確認できる' do
    sign_in user
    visit carts_path
    expect(page).to have_content '商品はありません'
  end

  it 'カートに商品を追加できる' do
    sign_in user
    visit product_path(product)

    expect {
      click_on 'カートに追加'
    }.to change { CartItem.count }.by(1)
  end

  it 'カートを通して商品を購入できる' do
    sign_in user
    visit product_path(product)
    click_on 'カートに追加'
    click_on '購入にすすむ'
    fill_in '名前', with: '武田鉄矢'
    fill_in '配送先', with: '東京都杉並区'
    select '2019/10/14', from: 'order_delivery_date'
    expect {
      click_on '購入する'
    }.to change { Order.count }.by(1)
  end

  it '購入後はカートの中身が空になる'

  end
