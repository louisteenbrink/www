class AddTrackedToApply < ActiveRecord::Migration
  def change
    add_column :applies, :tracked, :boolean, null: false, default: false
  end
end
