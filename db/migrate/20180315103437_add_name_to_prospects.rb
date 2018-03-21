class AddNameToProspects < ActiveRecord::Migration[5.1]
  def change
    add_column :prospects, :name, :string
  end
end
