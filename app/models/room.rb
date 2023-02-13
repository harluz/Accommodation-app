class Room < ApplicationRecord
  has_one_attached :room_image

  validates :name, presence: true
  validates :introduction, length: { maximum: 300}
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :adress, presence: true
  validates :price, presence: true
end
