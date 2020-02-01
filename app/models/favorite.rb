class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  counter_culture :plan
end
