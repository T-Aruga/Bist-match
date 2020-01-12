FactoryBot.define do
  factory :restaurant do
    name { '叙々苑' }
    longitude { 139.686854 }
    latitude { 35.682952 }
    address { '〒160-0023 東京都新宿区西新宿3-20-2 東京オペラシティビル53F' }
    budget { 7500 }
    line { '京王新線' }
    station { '初台駅' }
    walk { 1 }
    pc_url { 'https://r.gnavi.co.jp' }
    image_url { 'https://uds.gnst.jp/rest/img/9f2jv1wm0000/t_003o.jpg' }
    user_id { 1 }

    trait :no_name do
      name {}
    end
  end
end
