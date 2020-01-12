# FactoryBot.define do
#   factory :guest_review, class: Review do
#     comment { 'aaa' }
#     star { 1 }
#     plan_id { 1 }
#     reservation_id { 1 }
#     guest_id { 1 }
#     host_id { 2 }
#     association :host
#     association :guest
#     type { GuestReview }
#   end

#   trait :other_review do
#     guest_id { 3 }
#   end

#   trait :max_rating do
#     star { 5 }
#   end

# end
