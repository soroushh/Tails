class VAT
  Products = JSON.parse(File.read("pricing.json"))
  def initialize(list_of_products)
    @list_of_products = list_of_products
  end

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
