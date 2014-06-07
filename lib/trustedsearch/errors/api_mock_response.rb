class ApiMockResponse
  attr_accessor :message, :body, :code

  def initialize(message, body = nil, code = 500)
    @message = message
    @body = body
    @code = code
  end
end