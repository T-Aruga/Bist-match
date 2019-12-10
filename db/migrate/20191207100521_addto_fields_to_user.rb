class AddtoFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :description, :text
    add_column :users, :image_id, :string
    add_column :users, :sex, :integer, default: 0, null: false
    add_column :users, :age, :integer
    add_column :users, :favorite_store, :string
    add_column :users, :job, :string
    add_column :users, :jenre_id, :integer
    add_column :users, :active, :boolean, default: false, null: false
  end
end
