class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.integer :budget
      t.string :line
      t.string :station
      t.integer :walk
      t.string :pc_url
      t.string :image_url

      t.timestamps
    end
  end
end
