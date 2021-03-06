require 'net/http'
require 'uri'
require 'json'

class VoiceRecognitionServerApiConnector
  class Error < StandardError; end

  attr_reader :api_url, :api_port
  attr_accessor :data, :errors

  def initialize options = {}
    ap 'VoiceRecognitionServerApiConnector#initialize'
    server = VoiceRecognitionServer.first

    @api_port = server.api_port
    @api_url  = server.domain_name

    ap @api_port
    ap @api_url
  rescue NoMethodError => e
    raise Error.new "Please add 'api_url' and 'api_port' keys into your configuration"
  end

  def get_history options = {}
    process { resource.get(route_for('dot_histoire', options)) }
  end

  def get_path options = {}
    process { resource.get(route_for('dot_itineraire', options)) }
  end

  def get_weather options = {}
    process { resource.get(route_for('dot_meteo', options)) }
  end

  def get_text_to_speech options = {}
    process { resource.get(route_for('dot_text_to_speech', options)) }
  end

  def get_sleep_mode options = {}
    process { resource.get(route_for('dot_veille', options)) }
  end

  def process
    @data, @errors = [nil, nil]

    response = yield
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => e # API unreachable
    raise Error.new 'API is unreachable'
  else
    case response
    when Net::HTTPSuccess
      begin
        result = (JSON.parse(response.body).with_indifferent_access rescue {})
        @data = result&.dig :data

        self
      rescue JSON::ParserError => e
        raise Error.new e.message
      end
    else
      ap 'error from api'
      begin
        @errors = (JSON.parse(response.body).with_indifferent_access rescue {})

        self
      rescue JSON::ParserError => e
        raise Error.new e.message
      end
    end
  end

  private
    def route_for path, options = {}
      "/sarah/#{path.to_s}?#{URI.encode_www_form(options)}"
    end

    def headers params = {}
      params.merge('Content-Type' => 'application/json', 'Accept' => 'application/json')
    end

    def resource
      http = Net::HTTP.new @api_url, @api_port

      http
    end
end
