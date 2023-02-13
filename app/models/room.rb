class Room < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  validates :name, presence: true
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :adress, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0 }
end
