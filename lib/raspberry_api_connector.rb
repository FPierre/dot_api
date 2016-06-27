require 'net/http'
require 'uri'
require 'json'

class RaspberryApiConnector
  class Error < StandardError; end

  attr_reader :api_url, :api_port
  attr_accessor :data, :errors

  def initialize option = {}
    ap 'RaspberryApiConnector#initialize'
    raspberry = Raspberry.find_by name: 'RASP_INTERNE'

    @api_port = 8888
    @api_url  = raspberry.ip_address
  rescue NoMethodError => e
    raise Error.new "Please add 'api_url' and 'api_port' keys into your configuration"
  end

  def get_room_occupied options = {}
    process { resource.get(route_for('setLedMode.py', options), headers) }
  end

  def process
    @data, @errors = [nil, nil]

    response = yield

    # ap response.code

    self
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => e # API unreachable
    raise Error.new 'API is unreachable'
  else
    # case response
    # when Net::HTTPSuccess
    #   # ap 'no error from api'
    #   # begin
    #   #   result = (JSON.parse(response.body).with_indifferent_access rescue {})
    #   #   ap result
    #   #   @data = result&.dig :data

    #   #   self
    #   # rescue JSON::ParserError => e
    #   #   raise Error.new e.message
    #   # end

    #   self
    # else
    #   # ap 'error from api'
    #   # begin
    #   #   @errors = (JSON.parse(response.body).with_indifferent_access rescue {})

    #   #   self
    #   # rescue JSON::ParserError => e
    #   #   raise Error.new e.message
    #   # end

    #   self
    # end
  end

  private
    def route_for path, options = {}
      "#{path.to_s}?#{URI.encode_www_form(options)}"
    end

    def headers params = {}
      params.merge('Content-Type' => 'application/json', 'Accept' => 'application/json')
    end

    def resource
      http = Net::HTTP.new @api_url, @api_port

      http
    end
end
