class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories
  has_many :order_items

  has_one_attached :image

  validates :product_name,:description ,presence: true
  validates :price , :numericality => { greater_than: 0 }
  validates :production_date ,:exp_date ,presence: true
  validate :exp_date_after_product_date
  validates :quantity ,:numericality => {greater_than_or_equal_to: 0 }

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
end
