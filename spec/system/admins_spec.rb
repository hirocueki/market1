require 'rails_helper'

RSpec.describe "サイト管理者", type: :system do
  before do
    driven_by(:rack_test)
  end

  it '商品マスタを登録することができる' do
    visit admin_products_path
    click_on '商品の追加'

    fill_in '名前', with: '猛々しい竹'
    fill_in '価格', with: 3200
    fill_in '説明文', with: '中国の山奥で採れる貴重な品種「猛々竹」です。ハリのある材質で耐久度は高いです。'
    expect{
      click_on '作成'
    }.to change{ Product.count }.by(1)
  end

  it '商品一覧画面での表示順を設定できる'
  it '登録ユーザを管理することができる'

end
