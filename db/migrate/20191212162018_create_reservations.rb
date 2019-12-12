class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :price
      t.integer :user_id
      t.integer :plan_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
