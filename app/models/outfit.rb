class Outfit < ApplicationRecord
  belongs_to :user

  validates :image, presence: true
end
