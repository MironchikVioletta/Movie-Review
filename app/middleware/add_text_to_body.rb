# frozen_string_literal: true

class AddTextToBody
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)

    if @headers['Content-Type'] == 'text/html; charset=utf-8'
      @response.body += '<!-- We are hiring please contact 202 03 27 -->'
      @headers['Content-Length'] = @response.bodyh.bytesize.to_s
     end

    [@status, @headers, @response]
  end
end
