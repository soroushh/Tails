require "sinatra"
require "sinatra/namespace"
require "json"
require_relative "./lib/order.rb"

namespace '/api/v1' do
  # before do
  #   content_type 'application/json'
  # end

  post '/features' do
    order = Order.new(JSON.parse(request.body.read)["order"]["items"])
    {"Total price"=>order.total_price(), "Total_VAT"=>order.total_VAT()}.to_json()
  end

end
