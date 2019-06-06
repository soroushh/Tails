require "order"

describe Order do

  before(:each) do
    @order = order = Order.new([
      {"product_id"=>1, "quantity" => 2},
      {"product_id" =>2, "quantity" => 3}
      ])
  end

  context "#total_price" do

    it "We can calculate the total price of an order\
    with accuracy of 0.01 and an exchange_rate different form 1." do
      ex_rate = 1.5
      expect(@order.total_price(0,ex_rate)).to eq ((2*599 + 3*250)*1.5).round(2)
    end

    it "We can calculate the total price of an order in pennies with the\
    accuracy of 1." do
    expect(@order.penny_total_price).to eq((2*599 + 3*250).round())
    end

  end

end
