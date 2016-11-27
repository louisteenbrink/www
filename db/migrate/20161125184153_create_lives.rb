class CreateLives < ActiveRecord::Migration[5.0]
  def change
    create_table :lives do |t|
      t.string :category
      t.references :user, index: true, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.string :url
      t.string :batch_slug
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
