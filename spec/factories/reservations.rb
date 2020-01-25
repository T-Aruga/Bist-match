FactoryBot.define do
  factory :reservation do
    price { 100 }
    user_id { 1 }
    plan_id { 1 }

    trait :approved do
      status { 2 }
    end

    trait :other_plan do
      plan_id { 2 }
    end
  end
end
