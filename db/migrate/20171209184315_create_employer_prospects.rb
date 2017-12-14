class CreateEmployerProspects < ActiveRecord::Migration[5.1]
  def change
    create_table :employer_prospects do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :company
      t.string :website
      t.string :targets, array: true
      t.string :locations, array: true
      t.string :message

      t.timestamps
    end
  end
end
