# frozen_string_literal: true

class AntiDdos < Rack::Request
  $requests_data = {}
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    @status, @headers, @response = @app.call(env)
    ip = request.ip.to_s

    if @headers['Content-Type']&.start_with? 'text/html'
      $requests_data[ip] ||= []
      $requests_data[ip] = $requests_data[ip].last(5)
      $requests_data[ip] << Time.now

      if $requests_data[ip][-3]&.> Time.now - 2.seconds
        Rails.logger.info "[AntiDdos] blocking request from #{ip}"
        return [429, { 'Content-Type' => 'text/plain' }, ["Too Many Requests\n"]]
      end
    end
    [@status, @headers, @response]
  end
end
