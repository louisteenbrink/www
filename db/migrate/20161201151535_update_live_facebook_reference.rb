class UpdateLiveFacebookReference < ActiveRecord::Migration[5.0]
  def change
    remove_column :lives, :url
    add_column :lives, :facebook_url, :string
  end
end
