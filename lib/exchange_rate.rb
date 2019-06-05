require 'net/http'

require "json"
class Exchange_rate
  def initialize(currency)
    @currency = currency
  end

  def find_rate()
    # response = Net::HTTP.get_response('https://free.currconv.com','/api/v7/convert?q=GBP_IRR&compact=ultra&apiKey=2d46a9b5b650dca0dbb1').body
    uri_string = "https://free.currconv.com/api/v7/convert?q=GBP_"\
    "#{@currency}&compact=ultra&apiKey=2d46a9b5b650dca0dbb1"
    uri = URI(uri_string)
    res = Net::HTTP.get_response(uri)
    return(JSON.parse(res.body)["GBP_#{@currency}"])
  end
end
