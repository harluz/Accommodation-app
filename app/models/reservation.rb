class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :count_person, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :start_check
  validate :start_end_check

  def start_check
    if check_in && check_in  < Date.today
      errors.add(:check_in, message: "は今日より前の日付は登録できません。")
    end
  end

  def start_end_check
    if check_out && check_in && check_out < check_in
      errors.add(:check_out, message: "はチェックインより前の日付は登録できません。")
    end
  end
end
