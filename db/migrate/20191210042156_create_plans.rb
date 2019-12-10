class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :summary
      t.integer :price
      t.integer :member
      t.time :start_time
      t.time :end_time
      t.date :plan_date
      t.datetime :deadline
      t.text :requirement
      t.integer :restaurant_id
      t.integer :genre_id
      t.integer :user_id
      t.integer :area_id
      t.integer :period_time
      t.integer :status
      t.boolean :is_holiday
      t.boolean :active

      t.timestamps
    end
  end
end
