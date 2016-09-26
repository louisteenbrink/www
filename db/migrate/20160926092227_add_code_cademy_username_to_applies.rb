class AddCodeCademyUsernameToApplies < ActiveRecord::Migration[5.0]
  def change
    add_column :applies, :codecademy_username, :string
  end
end
