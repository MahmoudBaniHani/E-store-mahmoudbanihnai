cat = Category.create(category_name:'AAA')
cat.save

100.times do
  p=Product.create(product_name:Faker::Commerce.unique.product_name,
                   price: Faker::Number.between(from: 1, to: 1000),
                   description: Faker::Hipster.sentence(),
                   store_id:1,
                   production_date:Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
                   exp_date:Faker::Date.between(from: '2020-09-23', to: '2022-09-25') ,
                   quantity:Faker::Number.between(from: 1, to: 50))
  p.categories << cat
  p.image.attach(
    io:  File.open(File.join(Rails.root,'app/assets/images/no-image.png')),
    filename: 'no-image.png'
  )
  p.save

end