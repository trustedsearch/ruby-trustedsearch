module TrustedSearch
  class APIResource
    include HTTParty

    def class_name
      self.class.name.split('::')[-1]
    end

    def base_path
      if self == APIResource
        raise NotImplementedError.new("APIResource is an abstract class. You should perform actions on its subclasses (i.e. Publisher)")
      end
      ""
    end

    def has_keys
      unless public_key ||= TrustedSearch.public_key
        raise AuthenticationError.new(
          "No public_key key provided. Set your public_key using 'TrustedSearch.public_key = <API-KEY>'. " +
          "You can retrieve your public_key from a TRUSTEDSearch rep. " +
          "See http://developers.trustedsearch.org/#/getting-started for details."
        )
      end

      unless private_key ||= TrustedSearch.private_key
        raise AuthenticationError.new(
          "No private_key provided. Set your private_key using 'TrustedSearch.private_key = <API-KEY>'. " +
          "You can retrieve your private_key from a TRUSTEDSearch rep. " +
          "See http://developers.trustedsearch.org/#/getting-started for details."
        )
      end
    end

    def get(api_resource, params = {}, body = '')
      @resource ||= api_resource
      has_keys()

      raise ArgumentError, "Params must be a Hash; got #{params.class} instead" unless params.is_a? Hash

      timestamp = get_time()

      url_to_sign = base_path + api_resource

      params.merge!(
        {
          apikey: TrustedSearch.public_key,
          signature: sign_request(TrustedSearch.private_key, url_to_sign, body, timestamp ),
          timestamp: timestamp
        }
      )

      resource_url = end_point + url_to_sign
      request('get', resource_url, params, body)
    end

    def get_time
      return Time.now.utc.to_i
    end

    def post(api_resource, params = {}, body = {})
      @resource ||= api_resource
      has_keys()

      raise ArgumentError, "Params must be a Hash; got #{params.class} instead" unless params.is_a? Hash

      timestamp = get_time()

      url_to_sign = base_path + api_resource

      params.merge!({
        apikey: TrustedSearch.public_key,
        signature: sign_request(TrustedSearch.private_key, url_to_sign, body, timestamp ),
        timestamp: timestamp
      })

      resource_url = end_point + url_to_sign
      request('post', resource_url, params, body)
    end

    def put(api_resource, params = {}, body = {})
      @resource ||= api_resource
      has_keys()

      raise ArgumentError, "Params must be a Hash; got #{params.class} instead" unless params.is_a? Hash

      timestamp = get_time()

      url_to_sign = base_path + api_resource

      params.merge!({
        apikey: TrustedSearch.public_key,
        signature: sign_request(TrustedSearch.private_key, url_to_sign, body, timestamp ),
        timestamp: timestamp
      })

      resource_url = end_point + url_to_sign

      request('put', resource_url, params, body)
    end

    def sign_request( private_key, url, body, timestamp )

      body_md5 = (body == "") ? "" : Base64.strict_encode64( Digest::MD5.digest(body.to_json) )
      signature = url + body_md5 + timestamp.to_s
      signature = Base64.strict_encode64( Digest::HMAC.digest(signature, private_key , Digest::SHA1) )
      return signature
    end

    #get the end_point based upon the environment. Default to sandbox.
    def end_point
      if(TrustedSearch.environment == 'production')
        return TrustedSearch.environments[:production][:domain]
      elsif(TrustedSearch.environment == 'local')
        return TrustedSearch.environments[:local][:domain]
      else
        return TrustedSearch.environments[:sandbox][:domain]
      end
    end


    def request(method='get', resource_url, params, body)
      #puts resource_url
      #puts params.to_json

      timeout = TrustedSearch.api_timeout
      begin

        case method
        when 'get'
          response = self.class.get(resource_url, query: params, timeout: timeout)
        when 'post'
          response = self.class.post(resource_url, {:query => params, :body => body.to_json, :timeout => timeout } )
        when 'put'
          response = self.class.put(resource_url, {:query => params, :body => body.to_json, :timeout => timeout } )
        end

      rescue Timeout::Error
        raise ConnectionError.new("Timeout error (#{timeout}s)")
      end
      process(response)
    end


    def process(response)
      # puts response.code
      # body = JSON.parse(response.body)
      # puts body.to_json
      # puts response.message

      case response.code

      when 200, 201, 204
        APIResponse.new(response)
      when 400, 404, 409
        raise InvalidRequestError.new(response, response.code)
      when 401
        raise AuthenticationError.new(response, response.code)
      else
        error = Error.new(response.message, response.code)
        error.body = response.body
      raise error

      end

    end
  end
end