class AddTotalCostToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :total_cost, :integer
  end
end
