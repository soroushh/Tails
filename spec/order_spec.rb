require "order"

describe Order do

  context "#total_price" do
    it "We can calculate the total price of an order" do
      order = Order.new([{"product_id"=>1, "quantity" => 2},
        {"product_id" =>2, "quantity" => 3}])
      expect(order.total_price).to eq (2*599 + 3*250)
    end
  end

  context "#total_VAT" do
    it "We can calcualte the total VAT of an order" do
      order = Order.new([{"product_id" =>1 , "quantity" => 3},
        {"product_id" =>2 , "quantity" => 4}])
      expect(order.total_VAT()).to eq (599*3*0.2 + 4*250*0).round()
    end
  end

  context "#id_price_VAT" do
    it "We can have all the products of an order separatly by their price and VAT" do
      order = Order.new([{"product_id" =>1 , "quantity" => 3},
        {"product_id" =>2 , "quantity" => 4}])

      expect(order.id_price_VAT()).to eq (
        [ {"product_id" => 1 , "value" => 3*599 , "VAT" => (3*599*0.2).round()},
          {"product_id" => 2 , "value" => 4*250 , "VAT" => (4*250*0).round}
        ]
      )
    end

  end

end
