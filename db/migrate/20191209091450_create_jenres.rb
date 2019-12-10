class CreateJenres < ActiveRecord::Migration[5.2]
  def change
    create_table :jenres do |t|
      t.string :name
      t.string :image_id

      t.timestamps
    end
  end
end
