require "sinatra"
require "sinatra/namespace"
require "json"
require_relative "./lib/order.rb"
require_relative "./lib/VAT.rb"
require_relative "./lib/Separated_order_items.rb"
require_relative "./lib/exchange_rate.rb"
require_relative "./lib/total_money.rb"

namespace '/api/v1' do
  before do
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end

  post '/orders' do
    order = Order.new(@request_payload["order"]["items"])
    vat = VAT.new(@request_payload["order"]["items"])
    all_items = Separated_order_items.new(@request_payload["order"]["items"])
    {
       "Total price"=>order.penny_total_price(),
       "Total_VAT"=>vat.penny_total_VAT(),
       "All" => all_items.penny_show_all()
     }.to_json()
  end
end

namespace '/api/v2' do
  before do
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end

  post '/orders' do
    order = Order.new(@request_payload["order"]["items"])
    vat = VAT.new(@request_payload["order"]["items"])
    all_items = Separated_order_items.new(@request_payload["order"]["items"])
    ex_rate = Exchange_rate.new(@request_payload["currency"])
    total = Total_money.new(order,vat,ex_rate.find_rate())
    {
    "Total price" => order.total_price(0, ex_rate.find_rate()),
    "Total_VAT"=> vat.total_VAT(0, ex_rate.find_rate()),
    "All"=> all_items.show_all(ex_rate.find_rate()),
    "total_money" => total.all_money_paid()
    }.to_json()
  end
end
