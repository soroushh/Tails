class Total_money
  def initialize(order, vat,ex_rate = 1)
    @order = order
    @vat = vat
    @ex_rate = ex_rate
  end

  def all_money_paid()
    @order.total_price(0,@ex_rate) + @vat.total_VAT(0,@ex_rate)
  end
end
