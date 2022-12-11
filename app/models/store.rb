class Store < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :products

  validates :store_name,presence: true
  validates :phone ,presence: true,length: {maximum:12,minimum: 9}
  validates :status,presence: true

  enum :status => [:open,:close]
end
