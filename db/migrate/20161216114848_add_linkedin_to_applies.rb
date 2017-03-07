class AddLinkedinToApplies < ActiveRecord::Migration[5.0]
  def change
    add_column :applies, :linkedin, :string
  end
end
