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

    it "We can calculate the total VAT of an order in pennies with accuracy of 1" do
      expect(@order.penny_total_VAT()).to eq((2*599*0.2 + 3*250*0).round())
    end
  end

  context "#id_price_VAT" do
    it "We can have all the products of an order separatly by their price and VAT\
    with accuracy of 0.01 and deifferent exchange rate." do
      ex_rate = 1.5
      expect(@order.id_price_VAT(ex_rate)).to eq (
        [
          {
            "product_id" => 1 ,
            "value" => (2*599)*ex_rate.round(2) ,
            "VAT" => (2*599*0.2*ex_rate).round(2)
          },
          {
            "product_id" => 2 ,
            "value" => (3*250*ex_rate).round(2) ,
            "VAT" => (3*250*0*ex_rate).round(2)
          }
        ]
      )
    end

    it "We can have all the products of an order separatly by their price and VAT\
    in pennies with accuracy of 1." do
      expect(@order.penny_id_price_VAT()).to eq (
        [
          {
            "product_id" => 1 ,
            "value" => (2*599).round() ,
            "VAT" => (2*599*0.2).round()
          },
          {
            "product_id" => 2 ,
            "value" => (3*250).round() ,
            "VAT" => (3*250*0).round()
          }
        ]
      )
    end
  end


end
