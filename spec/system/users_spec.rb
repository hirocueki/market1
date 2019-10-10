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
  it 'ショッピングカートを通して商品を購入できる'

end
