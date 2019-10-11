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
    visit cart_path(user.cart)
    expect(page).to have_content '商品はありません'
  end

  it 'ショッピングカートを通して商品を購入できる' do
    sign_in user
    visit product_path(product)
    click_on 'カートに追加'
    click_on '購入にすすむ'
    fill_in '名前', with: user.name
    fill_in '配送先住所', with: user.address
    click_on '購入する'

    expect(Order.count).to eq 1
  end

  end
