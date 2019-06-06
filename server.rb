require "sinatra"
require "sinatra/namespace"
require "json"
require_relative "./lib/order.rb"
require_relative "./lib/exchange_rate.rb"

namespace '/api/v1' do

  post '/orders' do
    order = Order.new(JSON.parse(request.body.read)["order"]["items"])
    {"Total price"=>order.penny_total_price(), "Total_VAT"=>order.penny_total_VAT(),
       "All" => order.penny_id_price_VAT() }.to_json()
  end
end

namespace '/api/v2' do
  before do
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end

  post '/orders' do
    order = Order.new(@request_payload["order"]["items"])
    ex_rate = Exchange_rate.new(@request_payload["currency"])
    {
    "Total price"=>order.total_price(0, ex_rate.find_rate()),
    "Total_VAT"=>order.total_VAT(0, ex_rate.find_rate()),
    "All"=> order.id_price_VAT(ex_rate.find_rate())
     }.to_json()
  end
end
