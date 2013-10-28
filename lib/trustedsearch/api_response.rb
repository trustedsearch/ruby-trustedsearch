module TrustedSearch
  class APIResponse
    attr_reader :meta, :data, :request

    def initialize(response)
      @request = response.request
      @data = response.body.strip.to_json
    end

  end
end