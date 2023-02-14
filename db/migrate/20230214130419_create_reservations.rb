class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :count_person, null: false
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
