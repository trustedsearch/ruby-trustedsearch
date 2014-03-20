module TrustedSearch
  class APIResponse
    attr_reader :meta, :data, :request, :code

    def initialize(response)
			@request = response.request
      @code = response.code
      #handle case where body has no response and thus JSON.parse requires octet aka a byte.
      @data = (response.body.length >=2) ? JSON.parse(response.body.strip) : nil

      #Lets symbolize Version responses.
      if(TrustedSearch::api_version == 2)
      	@data = self.symbolize_keys(@data)
      end
    end

    def symbolize_keys(x)
      if x.is_a? Hash
        x.inject({}) do |result, (key, value)|
          new_key = case key
                    when String then key.to_sym
                    else key
                    end
          new_value = case value
                      when Hash then symbolize_keys(value)
                      when Array then symbolize_keys(value)
                      else value
                      end
          result[new_key] = new_value
          result
        end
      elsif x.is_a? Array
        x.map {|el| symbolize_keys(el)}
      else
        x
      end
    end

  end
end