require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザ登録できる'
  it 'ショッピングカートを通して商品を購入できる'

end
