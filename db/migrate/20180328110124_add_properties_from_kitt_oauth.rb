class AddPropertiesFromKittOauth < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :kitt_id, :string
    add_column :users, :email, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean
    add_column :users, :cities, :string, array: true
  end
end
