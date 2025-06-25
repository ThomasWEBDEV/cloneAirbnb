class CreateGardens < ActiveRecord::Migration[7.1]
  def change
    create_table :gardens do |t|
      t.string :title
      t.text :description
      t.string :address
      t.decimal :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
