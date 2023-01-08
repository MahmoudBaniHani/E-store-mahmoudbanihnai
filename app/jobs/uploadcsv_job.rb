class UploadcsvJob < ApplicationJob
  queue_as :default

  def perform(args)
    count = 0
    total_row = CSV.foreach(args,headers: true).count
    CSV.foreach(args, headers: true) do |row|
      product_info = Product.find_by(:product_name => row['product_name'])
      user = User.find(row['user_id'].to_i)
      store = Store.find(row['store_id'].to_i)

      category = Category.find_by(:id => row['category_id'].to_i)
      if product_info.nil?
        product = Product.new()
        product.categories << category unless category.nil?
        product.product_name = row['product_name']
        product.description = row['description']
        product.price = row['price'].to_i
        product.production_date = row['production_date']
        product.exp_date = row['exp_date']
        product.quantity = row['quantity'].to_i
        # product.image.attach(io:File.open(File.join(Rails.root,'app/assets/images/'+rand(1..20).to_s+'.png')),
        #                      filename: rand(1..20).to_s+'.png', content_type: 'image/png')
        product.store_id = row['store_id'].to_i
        product.user_id = row['user_id'].to_i
        product.save unless store.nil? and user.nil?
      else
        product_params = {}
        row.each do |key, value|
          (key == 'category_id') ? next : product_params[key] = value
        end
        # product_info.image.attach(io:File.open(File.join(Rails.root,'app/assets/images/'+rand(1..20).to_s+'.png')),
        #                           filename: rand(1..20).to_s+'.png', content_type: 'image/png')
        product_info.update(product_params)
        product_info.save
      end
      count += 1
      progress = ((count / total_row.to_f) * 100).round(2)
      # puts "**********************************",total_row,count,progress
      ActionCable.server.broadcast "AlertsChannel", progress
    end
  end
end
