module TrustedSearch
  class Error < StandardError
    attr_accessor :message, :code, :body

    def initialize(response = nil, code = nil )

      @message = ''
      body = ''
      if(response.respond_to?("message"))
        @message = response.message.to_s
      end

      if(response.respond_to?("body") && (response.body != nil))
        body = JSON.parse(response.body.to_s)
        # Use API message instead of exception message for more detail about issue when possible.
        if(body.key?('message'))
          @message = body['message']
        end
      end
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