class LineItem < ActiveRecord::Base
  has_many :order
  belongs_to :product
  belongs_to :cart
  def total_price
    product.price * quantity
  end
end
