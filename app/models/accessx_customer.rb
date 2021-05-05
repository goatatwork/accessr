require 'faraday'
require 'json'

class AccessxCustomer
  def all
    api_data[:data]
  end

  def meta
    api_data.excluding :data
  end

  def api_data
    JSON.parse(api_request, symbolize_names: true)
  end

  def api_request
    @response = Faraday.get 'http://accessx_nginx/api/customers' do |request|
      request.params['accessr'] = "true"
      request.headers['Content-Type'] = 'application/json'
    end

    @response.body
  end

  def traverse_pagination
    meta[:last_page].times do |time|
      puts "Hello #{time}"
    end
  end
end
