class MoreColumnsOnLives < ActiveRecord::Migration[5.0]
  def change
    add_column :lives, :city_slug, :string
    add_column :lives, :subtitle, :string
    add_column :lives, :link, :string
  end
end
