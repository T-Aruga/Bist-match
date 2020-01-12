# FactoryBot.define do
#   factory :review, aliases: [:GuestReview, :HostReview] do
#     comment { 'aaa' }
#     star { 1 }
#     plan_id { 1 }
#     reservation_id { 1 }
#     guest_id { 1 }
#     host_id { 2 }
#     association :guest
#     association :host
#     type { GuestReview }
#   end

#   trait :other_review do
#     guest_id { 3 }
#   end

#   trait :max_rating do
#     star { 5 }
#   end

# end
