module TrustedSearch
  class APIResponse
    attr_reader :meta, :data, :request

    def initialize(response)
      @request = response.request
      @data = JSON.parse(response.body)
    end

  end
end