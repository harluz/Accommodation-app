class User < ApplicationRecord
  # :avatarはファイル名　なんでもいい
  has_one_attached :avatar
  
  validates :name, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction, length: { maximum: 500 }
end
