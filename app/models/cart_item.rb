
class CartItem
  attr_reader :product, :quantity, :price_type

  def initialize(product,price_type = nil)
    @product = product
    @quantity = 1
    @final_price = BillingPrice.find_by_product_id_and_price_type(@product.product_id,price_type) unless price_type.blank?
    @final_price = BillingPriceType.find_by_product_id_and_price_type(@product.product_id,"General") if @final_price.blank?
  end

  def increment_quantity
    @quantity += 1
  end

  def name
    @product.name
  end
  
  def product_code
    @product.product_id
  end
  
  def price
    @final_price.amount * @quantity
  end
end
