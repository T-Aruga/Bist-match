require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#age' do
    context '20年前の生年月日の場合' do
      let(:user) {User.new(age: Time.zone.now - 20.years)}

      it '年齢が20才であること' do
        expect(user.age).to eq 20
      end
    end
  end
end
