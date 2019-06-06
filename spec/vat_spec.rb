require "VAT"

describe VAT do
  before(:each) do
    @vat = VAT.new(
      [
        {"product_id"=>1, "quantity" => 2},
        {"product_id" =>2, "quantity" => 3}
      ]
    )
  end
  context "#total_vat" do
    it "We can calcualte the total VAT of an order\
    with accuracy of 0.01 and an exchange rate different from 1." do
      ex_rate = 2.5
      expect(@vat.total_VAT(0,ex_rate)).to eq (2*599*0.2 + 3*250*0)*2.5.round(2)
    end

    it "We can calculate the total VAT of an order in pennies with accuracy of 1" do
      expect(@vat.penny_total_VAT()).to eq((2*599*0.2 + 3*250*0).round())
    end
  end
end
