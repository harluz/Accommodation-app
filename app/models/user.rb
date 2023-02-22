class User < ApplicationRecord
  # :avatarはファイル名　なんでもいい
  has_one_attached :avatar

  has_many :reservations, dependent: :destroy
  has_many :rooms
  
  validates :name, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction, length: { maximum: 500 }
end
