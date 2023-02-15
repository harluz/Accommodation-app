class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :count_person, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :start_end_check

  def start_end_check
    if check_out && check_in && check_out < check_in
      errors.add(:check_out, message: "はチェックインより前の日付は登録できません。")
    end
  end
end
