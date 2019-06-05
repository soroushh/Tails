require "order"

describe Order do

  context "#total_price" do
    it "We can calculate the total price of an order" do
      order = Order.new([{"product_id"=>1, "quantity" => 2}, {"product_id" =>2, "quantity" => 3}])
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

end
