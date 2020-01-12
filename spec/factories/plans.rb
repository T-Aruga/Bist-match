FactoryBot.define do

  factory :plan do
    title { 'sample' }
    summary { 'sampletext' }
    price { 100 }
    member { 4 }
    plan_date { 2019-12-25 }
    deadline { 2019-12-24 }
    requirement { 'sampletext' }
    longitude { 139.686854 }
    latitude { 35.682952 }
    restaurant_id { 1 }
    jenre_id { 1 }
    user_id { 1 }
    area_id { 1 }
    start_time { Time.now }
    end_time { Time.now }
    period_time { 0 }
    status { 1 }
    is_holiday { 1 }

    trait :no_title do
      title {}
    end

    trait :no_price do
      price {}
    end

    trait :no_latitude do
      latitude {}
    end

    trait :no_longitude do
      longitude {}
    end

    trait :true_active do
      active { 1 }
    end

    trait :false_active do
      active { 0 }
    end

    trait :no_restinfo do
      restaurant_id {}
      latitude {}
      longitude {}
    end

    trait :too_long_title do
      title {Faker::Lorem.characters(number: 41)}
    end
  end
end
