require "sinatra"
require "sinatra/namespace"
require "json"
require_relative "./lib/order.rb"

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  post '/features' do
    file = JSON.parse(request.body.read)
    order = Order.new(file["order"]["items"])
    {"Total price"=>order.total_price()}.to_json()
  end


end
