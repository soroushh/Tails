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

  context "#total_VAT" do
    it "We can calcualte the total VAT of an order\
    with accuracy of 0.01 and an exchange rate different from 1." do
      ex_rate = 2.5
      expect(@order.total_VAT(0,ex_rate)).to eq (2*599*0.2 + 3*250*0)*2.5.round(2)
    end
  end

  context "#id_price_VAT" do
    it "We can have all the products of an order separatly by their price and VAT" do
      order = Order.new([
        {"product_id" =>1 , "quantity" => 3},
        {"product_id" =>2 , "quantity" => 4}
        ])

      expect(order.id_price_VAT()).to eq (
        [
          {
            "product_id" => 1 , "value" => (3*599).round(2) ,
            "VAT" => (3*599*0.2).round(2)
          },
          {
            "product_id" => 2 , "value" => (4*250).round(2) ,
            "VAT" => (4*250*0).round(2)
          }
        ]
      )
    end
  end

  context "If we have an eachange rate different from 1, we can see the price" do
    it "We are able to use eachange rate to calculate the price of order" do
      order = Order.new([
        {"product_id" =>1 , "quantity" => 4},
        {"product_id" =>2 , "quantity" => 3}
        ])

      expect(order.total_price(0,3)).to eq (3*(4*599 + 3*250))
    end
  end

end
