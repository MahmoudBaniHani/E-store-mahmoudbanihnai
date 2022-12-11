class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :stores
  has_many :orders

  validates :first_name, :last_name ,presence:true

  enum :role => [:admin,:owner,:customer]

  after_initialize :set_default_role, :if=>:new_record?


  private
  def set_default_role
    if self.role == 'customer'
      self.role ||= :customer
    else
      self.role ||= :owner
    end
  end
end
