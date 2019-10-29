require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ユーザの項目の確認（メールアドレス, パスワード, 送付先情報（名前、住所）)' do
    user = User.create(
          email: 'john@example.com',
          password: 'john12345',
          password_confirmation: 'john12345',
          name: 'ジョン',
          address: '222-4444 東京都江戸川区２−３−４'
    )
    expect(user).to be_valid
  end

  it '名前と住所は省略できる' do
    user = User.create(
      email: 'john@example.com',
      password: 'john12345',
      password_confirmation: 'john12345',
      )
    expect(user).to be_valid
  end
end
