require 'net/http'
require "json"


class Exchange_rate
  def initialize(currency)
    @currency = currency
  end

  # This method is responsible for receiving the exchange_rate of a specific currency
  # to the GBP from an API.
  def find_rate()
    uri_string = "https://free.currconv.com/api/v7/convert?q=GBP_"\
    "#{@currency}&compact=ultra&apiKey=2d46a9b5b650dca0dbb1"
    uri = URI(uri_string)
    res = Net::HTTP.get_response(uri)
    return(JSON.parse(res.body)["GBP_#{@currency}"]/100.0)
  end
end
