class AddTrackedToApply < ActiveRecord::Migration[4.2]
  def change
    add_column :applies, :tracked, :boolean, null: false, default: false
  end
end
