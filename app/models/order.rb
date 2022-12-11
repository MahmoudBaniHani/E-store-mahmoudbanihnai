class Order < ApplicationRecord
  belongs_to :user,optional: true
  has_many :order_items

  before_save :set_subtotal
  enum :status => [:waite,:done]

  def subtotal
    order_items.collect{|order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0 }.sum
  end
  def total
  end
  private
  def set_subtotal
    self[:subtotal] = subtotal
  end
  def set_total
    self[:total] = total
  end
end
