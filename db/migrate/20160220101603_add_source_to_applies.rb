class AddSourceToApplies < ActiveRecord::Migration[4.2]
  def change
    add_column :applies, :source, :string
  end
end
