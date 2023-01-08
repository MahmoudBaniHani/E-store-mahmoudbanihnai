admin = User.create(email:'admin@gmail.com',password:'123456',role:0,first_name:'Admin',last_name:'admin')
admin.save

store = Store.create(store_name:'smart-by',phone:'0791481305',status:0)
store.users << admin
store.save

cat = Category.create(category_name:'electronic')
cat.save

Product.delete_all
# 50.times do
#   p=Product.create(product_name:Faker::Commerce.unique.product_name,
#                    price: Faker::Number.between(from: 1, to: 500),
#                    description: Faker::Hipster.sentence(),
#                    store_id: 1,
#                    production_date:Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
#                    exp_date:Faker::Date.between(from: '2020-09-23', to: '2022-09-25') ,
#                    quantity:Faker::Number.between(from: 1, to: 50),
#                     user_id:2)
#   p.categories << 1
#   p.image.attach(
#     io:  File.open(File.join(Rails.root,'app/assets/images/no-image.png')),
#     filename: 'no-image.png'
#   )
#   p.save
# end