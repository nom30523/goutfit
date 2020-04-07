class Post < ApplicationRecord
  belongs_to :user
  belongs_to :outfit

  validates :appointed_day, presence: true, uniqueness: { scope: :user_id }
end
