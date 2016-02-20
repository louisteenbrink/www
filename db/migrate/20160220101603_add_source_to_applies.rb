class AddSourceToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :source, :string
  end
end
