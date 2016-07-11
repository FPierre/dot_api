require 'net/http'
require 'uri'
require 'json'

class RaspberryApiConnector
  class Error < StandardError; end

  attr_reader :api_url, :api_port
  attr_accessor :data, :errors

  def initialize option = {}
    ap 'RaspberryApiConnector#initialize'
    raspberry = Raspberry.find_by master_device: true

    @api_port = raspberry.api_port
    @api_url  = raspberry.domain_name

    ap @api_port
    ap @api_url
  rescue NoMethodError => e
    raise Error.new "Please add 'api_url' and 'api_port' keys into your configuration"
  end

  def get_room_occupied options = {}
    process { resource.get(route_for('setLedMode.py', options)) }
  end

  def process
    @data, @errors = [nil, nil]

    response = yield

    self
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => e # API unreachable
    raise Error.new 'API is unreachable'
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
