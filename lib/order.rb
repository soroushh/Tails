require "json"
class Order
  # Products = JSON.parse(File.read("new.json"))
  Products = JSON.parse('{
  	"prices": [
  		{
  			"product_id": 1,
  			"price": 599,
  			"vat_band": "standard"
  		},
  		{
  			"product_id": 2,
  			"price": 250,
  			"vat_band": "zero"
  		},
  		{
  			"product_id": 3,
  			"price": 250,
  			"vat_band": "zero"
  		},
  		{
  			"product_id": 4,
  			"price": 1000,
  			"vat_band": "zero"
  		},
  		{
  			"product_id": 5,
  			"price": 1250,
  			"vat_band": "standard"
  		}
  	],
  	"vat_bands": {
  		"standard": 0.2,
  		"zero": 0
  	}
  }
')
  def initialize(list_of_products)
    @list_of_products = list_of_products
    @id_price_VAT = []
  end

  def total_price(price = 0)
    @list_of_products.each do |product|
      price += product["quantity"]*find_price_by_product_id(product["product_id"])
    end
    price
  end

  def total_VAT(total_vat = 0)
    @list_of_products.each do |product|
      total_vat += product["quantity"]*find_price_by_product_id(product["product_id"])*find_VAT_amount_by_product_id(product["product_id"])
    end
    total_vat
  end

  def id_price_VAT(exchange_rate = 1)
    @list_of_products.each do |order|
      @id_price_VAT << {"product_id" => order["product_id"],
        "value" => find_price_by_product_id(order["product_id"])*order["quantity"]*exchange_rate,
        "VAT" => find_VAT_amount_by_product_id(order["product_id"])*find_price_by_product_id(order["product_id"])*order["quantity"]*exchange_rate
      }
    end
    @id_price_VAT
  end

  private

  def find_price_by_product_id(product_id)
    Products["prices"].each do |product|
      return product["price"] if product["product_id"]== product_id
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
