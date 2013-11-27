module TrustedSearch
  class Error < StandardError
    attr_accessor :message, :code, :body

    def initialize(response = nil, code = nil )

      body = JSON.parse(response.body)
      @message = body['message']
      @code    = code
      @body    = body

    end

    def to_s
      code_string = code.nil? ? "" : " (Code #{code})"
      "#{message}#{code_string}"
    end

    def message
        @message
    end


  end
end