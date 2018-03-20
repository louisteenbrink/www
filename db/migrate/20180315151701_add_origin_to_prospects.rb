class AddOriginToProspects < ActiveRecord::Migration[5.1]
  def change
    add_column :prospects, :origin, :string
  end
end
