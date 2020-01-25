FactoryBot.define do

  factory :user  do
    fullname { 'Alice Stark' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    phone_number { '11144448888' }
    description { 'sample text' }
    sex { 1 }
    age { 24 }
    favorite_store { 'マクドナルド' }
    job { '会社員' }
    image_id { 1 }
    jenre_id { 1 }
    stripe_id { '1' }

    trait :too_long_name do
      fullname {Faker::Lorem.characters(number: 31)}
    end

    trait :no_name do
      fullname {}
    end

    trait :no_description do
      description { '' }
    end

    trait :active_true do
      active { 1 }
    end

    trait :create_with_image do
      image {Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png")}
    end
  end

end
