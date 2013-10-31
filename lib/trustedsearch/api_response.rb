module TrustedSearch
  class APIResponse
    attr_reader :meta, :data, :request, :code

    def initialize(response)
      @request = response.request
      @code = response.code
      #handle case where body has no response and thus JSON.parse requires octet aka a byte.
      @data = (response.body.length >=2) ? JSON.parse(response.body.strip) : nil

    end

  end
end