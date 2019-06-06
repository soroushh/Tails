require "separated_order_items"

describe Separated_order_items do
  before(:each) do
    @all_items = Separated_order_items.new([
      {"product_id"=>1, "quantity" => 2},
      {"product_id" =>2, "quantity" => 3}
      ])
  end
  it "We can have all the products of an order separatly by their price and VAT\
  with accuracy of 0.01 and deifferent exchange rate." do
    ex_rate = 1.5
    expect(@all_items.show_all(ex_rate)).to eq (
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
    expect(@all_items.penny_show_all()).to eq (
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
