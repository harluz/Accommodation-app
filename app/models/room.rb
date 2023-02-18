class Room < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :reservations

  validates :name, presence: true
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :adress, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["adress", "created_at", "detail", "id", "name", "price", "updated_at", "user_id"]
  end
end
