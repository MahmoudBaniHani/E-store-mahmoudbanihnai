class CreateJoinTableProductCategory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :products do |t|
      t.index [:category_id, :product_id],name: "index_categories_products_on_category_id_and_product_id"
      t.index [:product_id, :category_id], name: "index_categories_products_on_product_id_and_category_id"

    end
  end
end
