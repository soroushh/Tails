require "json"
class Order

  Products = JSON.parse(File.read("pricing.json"))

  def initialize(list_of_products)
    @list_of_products = list_of_products
    @id_price_VAT = []
  end

  def total_price(price = 0,ex_rate = 1)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])*
      ex_rate
    end
    price.round(2)
  end

  def penny_total_price(price = 0)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])
    end
    price.round()
  end

  private

  def find_price_by_product_id(product_id, products = Products)
    products["prices"].each do |product|
      return product["price"] if product["product_id"]== product_id
    end
  end

  def find_VAT_status_by_product_id(product_id, products = Products)
    products["prices"].each do |product|
      return product["vat_band"] if product["product_id"] == product_id
    end
  end

  def find_VAT_amount_by_product_id(product_id)
    return 0 if find_VAT_status_by_product_id(product_id) == "zero"
    return 0.2 if find_VAT_status_by_product_id(product_id) == "standard"
  end

end
