require "json"
class Order
  Products = JSON.parse(File.read("new.json"))
  def initialize(hash)
    @hash = hash
  end

  def total_price(price = 0)
    @hash.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])
    end
    price
  end

  def total_VAT(total_vat = 0)
    @hash.each do |product|
      total_vat += product["quantity"]*find_price_by_product_id(product["product_id"])*find_VAT_amount_by_product_id(product["product_id"])
    end
    total_vat
  end


  def find_price_by_product_id(id)
    Products["prices"].each do |product|
      return product["price"] if product["product_id"]== id
    end
  end

  def find_VAT_status_by_product_id(product_id)
    Products["prices"].each do |product|
      return product["vat_band"] if product["product_id"] == product_id
    end
  end

  def find_VAT_amount_by_product_id(product_id)
    return 0 if find_VAT_status_by_product_id(product_id) == "zero"
    return 0.2 if find_VAT_status_by_product_id(product_id) == "standard"
  end

end
