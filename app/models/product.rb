class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories
  has_many :order_items
  belongs_to :user

  has_one_attached :image
  has_one_attached :file

  validates :product_name,:description ,presence: true
  validates :price , :numericality => { greater_than: 0 }
  validates :production_date ,:exp_date ,presence: true
  validate :exp_date_after_product_date
  validates :quantity ,:numericality => {greater_than_or_equal_to: 0 }
  validates :store_id ,:user_id ,presence: true

  scope :lower_price ,->{ Product.order(price: :asc)  }
  scope :high_price ,->{ Product.order(price: :desc) }


  private
  def exp_date_after_product_date
    return if exp_date.blank? || production_date.blank?
    if exp_date < production_date
      errors.add(:exp_date, "must be after the start date")
    end
  end

  def add_default_image
    unless image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'no-image.png')),
        filename: 'no_image.png', content_type: 'image/png'
      )
    end
  end
  def self.import(file)
    CSV.foreach(file.path,headers:true ) do |row|
      product_info = Product.find_by(:product_name => row['product_name'])
      user =  User.find(row['user_id'].to_i)
      store = Store.find(row['store_id'].to_i)

      category = Category.find_by(:id=>row['category_id'].to_i)
      if product_info.nil?
        product = Product.new
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
        product.save unless store.nil? or user.nil?
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
    end
  end
end
