require "total_money"
describe Total_money do
  it "We can calculate the total money of the order" do
    vat_double = double(total_VAT: 40)
    order_double = double(total_price: 50)
    total_money = Total_money.new( order_double , vat_double)
    expect(total_money.all_money_paid()).to eq(90)
    end
end
