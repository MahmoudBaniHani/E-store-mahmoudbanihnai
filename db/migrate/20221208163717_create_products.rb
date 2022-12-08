class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.float :price
      t.date :production_date
      t.date :exp_date
      t.integer :quantity
      t.text :image
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
