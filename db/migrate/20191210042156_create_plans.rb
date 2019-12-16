class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :summary
      t.integer :price
      t.integer :member
      t.datetime :start_time
      t.datetime :end_time
      t.date :plan_date
      t.date :deadline
      t.text :requirement
      t.float :longitude
      t.float :latitude
      t.integer :restaurant_id, null: false
      t.integer :jenre_id, default: 1, null: false
      t.integer :user_id, null: false
      t.integer :area_id, default: 1, null: false
      t.integer :period_time
      t.integer :status, default: 0
      t.boolean :is_holiday, default: false, null: false
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
