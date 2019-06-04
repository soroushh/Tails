require "json"
class Order
  Products = JSON.parse(File.read("new.json"))
  def initialize(hash)
    @hash = hash
  end

  def total_price()
    price = 0
    @hash.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])
    end
    price
  end

  def find_price_by_product_id(id)
    Products["prices"].each do |product|
      return product["price"] if product["product_id"]== id
    end
  end

end
