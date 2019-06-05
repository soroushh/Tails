require "order"

describe Order do
  context "#total_price" do
    it "We can calculate the total price of an order" do
      order = Order.new([{"product_id"=>1, "quantity" => 2}, {"product_id" =>2, "quantity" => 3}])
      expect(order.total_price).to eq (2*599 + 3*250)
  end



  end
end
