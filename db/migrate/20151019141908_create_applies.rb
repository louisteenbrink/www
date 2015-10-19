class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :email
      t.string :phone
      t.text :motivation
      t.integer :batch_id
      t.integer :city_id

      t.timestamps null: false
    end
  end
end
