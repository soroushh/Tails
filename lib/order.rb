require "json"
class Order

  # We define the Products hash as a constant from the pricing.json file.
  Products = JSON.parse(File.read("pricing.json"))

  # Every order has a list of products.
  def initialize(list_of_products)
    @list_of_products = list_of_products
    @id_price_VAT = []
  end

  # This method calculates the total price of an order by iterating over all products
  # and it can use different exchange rates which is 1 by default.
  def total_price(price = 0,ex_rate = 1)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])*
      ex_rate
    end
    price.round(2)
  end

  #This method is used to calculate the price of an order in pennies. There are
  # Two different methods for counting the price of an order, because the accuracy
  # of calculations for price in pennis is 1 but for price in other currencies is
  # 0.01
  def penny_total_price(price = 0)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])
    end
    price.round()
  end

  # This method is used to calculate the total_VAT of an order and we can have
  # exchange rates which is 1 by default.
  def total_VAT(total_vat = 0, ex_rate = 1)
    @list_of_products.each do |product|
      total_vat += product["quantity"]*find_price_by_product_id(product["product_id"])*
      find_VAT_amount_by_product_id(product["product_id"])*ex_rate
    end
    total_vat.round(2)
  end

  # This method is used to calculate the VAT of an order in pennies.
  def penny_total_VAT(total_vat = 0)
    @list_of_products.each do |product|
      total_vat += product["quantity"]*find_price_by_product_id(product["product_id"])*
      find_VAT_amount_by_product_id(product["product_id"])
    end
    total_vat.round()
  end

  # This method is used to make an array of all products with their price and
  # VAT.
  def id_price_VAT(ex_rate = 1)
    @list_of_products.each do |product|
      @id_price_VAT << {

        "product_id" => product["product_id"],

        "value" => (find_price_by_product_id(product["product_id"])*
        product["quantity"]*ex_rate).round(2),

        "VAT" => (find_VAT_amount_by_product_id(product["product_id"])*
        find_price_by_product_id(product["product_id"])*product["quantity"]*
        ex_rate).round(2)
      }
    end
    @id_price_VAT
  end

  # This method is used to make an array of all products with their price and
  #  VAT.
  def penny_id_price_VAT()
    @list_of_products.each do |product|
      @id_price_VAT << {

        "product_id" => product["product_id"],

        "value" => (find_price_by_product_id(product["product_id"])*
        product["quantity"]).round(),

        "VAT" => (find_VAT_amount_by_product_id(product["product_id"])*
        find_price_by_product_id(product["product_id"])*product["quantity"]).round()
      }
    end
    @id_price_VAT
  end


  private

  #  This is a private method to find the price of a single product by its id.
  def find_price_by_product_id(product_id, products = Products)
    products["prices"].each do |product|
      return product["price"] if product["product_id"]== product_id
    end
  end

  # This is a private method to find the VAT status of a product by its product
  # id that can be "zero" or "standard"
  def find_VAT_status_by_product_id(product_id, products = Products)
    products["prices"].each do |product|
      return product["vat_band"] if product["product_id"] == product_id
    end
  end

  #  This is a private method that shows the VAT ratio based on its status. 
  def find_VAT_amount_by_product_id(product_id)
    return 0 if find_VAT_status_by_product_id(product_id) == "zero"
    return 0.2 if find_VAT_status_by_product_id(product_id) == "standard"
  end

end
