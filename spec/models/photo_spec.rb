require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'アソシエーション' do
    it "Planモデルに属している" do
      is_expected.to belong_to(:plan)
    end
  end
end
