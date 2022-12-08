json.extract! product, :id, :product_name, :description, :price, :production_date, :exp_date, :quantity, :image, :store_id, :created_at, :updated_at
json.url product_url(product, format: :json)
