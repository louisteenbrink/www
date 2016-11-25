class CreateLives < ActiveRecord::Migration[5.0]
  def change
    create_table :lives do |t|
      t.string :category
      t.datetime :started_at
      t.datetime :ended_at
      t.string :url
      t.string :batch_slug

      t.timestamps
    end
  end
end
