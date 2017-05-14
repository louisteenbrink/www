class AddFromPathToProspects < ActiveRecord::Migration[5.0]
  def change
    add_column :prospects, :from_path, :string
  end
end
