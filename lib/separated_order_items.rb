class Separated_order_items

  Products = JSON.parse(File.read("pricing.json"))

  def initialize(list_of_products)
    @list_of_products = list_of_products
    @all_items = []
  end

  def show_all(ex_rate = 1)
    @list_of_products.each do |product|
      @all_items << {

        "product_id" => product["product_id"],

        "value" => (find_price_by_product_id(product["product_id"])*
        product["quantity"]*ex_rate).round(2),

        "VAT" => (find_VAT_amount_by_product_id(product["product_id"])*
        find_price_by_product_id(product["product_id"])*product["quantity"]*
        ex_rate).round(2)
      }
    end
    @all_items
  end

  # This method is used to make an array of all products with their price and
  #  VAT.
  def penny_show_all()
    @list_of_products.each do |product|
      @all_items << {

        "product_id" => product["product_id"],

        "value" => (find_price_by_product_id(product["product_id"])*
        product["quantity"]).round(),

        "VAT" => (find_VAT_amount_by_product_id(product["product_id"])*
        find_price_by_product_id(product["product_id"])*product["quantity"]).round()
      }
    end
    @all_items
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
