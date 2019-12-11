class Photo < ApplicationRecord

  belongs_to :plan
  attachment :image

end
