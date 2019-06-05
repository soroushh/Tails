require "json"
class Order
  Products = JSON.parse(File.read("new.json"))
  def initialize(list_of_products)
    @list_of_products = list_of_products
    @id_price_VAT = []
  end

  def total_price(price = 0,ex_rate = 1)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])*
      ex_rate
    end
    price.round()
  end

  def total_VAT(total_vat = 0, ex_rate = 1)
    @list_of_products.each do |product|
      total_vat += product["quantity"]*find_price_by_product_id(product["product_id"])*
      find_VAT_amount_by_product_id(product["product_id"])*ex_rate
    end
    total_vat.round()
  end

  def id_price_VAT(ex_rate = 1)
    @list_of_products.each do |product|
      @id_price_VAT << {"product_id" => product["product_id"],
        "value" => (find_price_by_product_id(product["product_id"])*
        product["quantity"]*ex_rate).round(),
        "VAT" => (find_VAT_amount_by_product_id(product["product_id"])*
        find_price_by_product_id(product["product_id"])*product["quantity"]*
        ex_rate).round()
      }
    end
    @id_price_VAT
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
