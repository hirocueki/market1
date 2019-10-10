require 'rails_helper'

RSpec.describe "サイト管理者", type: :system do
  before do
    driven_by(:rack_test)
  end

  it '商品マスタを登録することができる'
  it '商品一覧画面での表示順を設定できる'
  it '登録ユーザを管理することができる'

end
