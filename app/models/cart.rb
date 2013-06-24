class Cart
  attr_reader :items

  def initialize
      @items = []
  end

def add_product(product,price_type)
  current_item = @items.find {|item| item.product == product}
  if current_item
    current_item.increment_quantity
  else
    @items << CartItem.new(product,price_type)
  end
end

def remove_product(product)
  current_item = @items.find {|item| item.product == product}

  if current_item
    @items.delete(current_item)
  end
end

end


