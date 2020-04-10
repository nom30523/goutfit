class Outfit < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
