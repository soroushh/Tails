require "sinatra"
require "sinatra/namespace"
require "json"
require_relative "./lib/order.rb"
require_relative "./lib/exchange_rate.rb"

namespace '/api/v1' do
  # before do
  #   content_type 'application/json'
  # end

  post '/orders' do
    order = Order.new(JSON.parse(request.body.read)["order"]["items"])
    {"Total price"=>order.total_price(), "Total_VAT"=>order.total_VAT(), "All" => order.id_price_VAT()}.to_json()
  end
end

namespace '/api/v2' do
  post '/orders' do
    order = Order.new(JSON.parse(request.body.read)["order"]["items"])
    exchange_rate = Exchange_rate.new("IRR")
    {"Total price"=>order.total_price()*exchange_rate.find_rate(), "Total_VAT"=>order.total_VAT()*exchange_rate.find_rate(), "All" => order.id_price_VAT(exchange_rate.find_rate())}.to_json()

  end
end
