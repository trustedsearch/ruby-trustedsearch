module TrustedSearch
  class Api < APIResource
  end
end

module TrustedSearch
  class V1 < Api

  	def base_path
  	  if self == APIResource
  	    raise NotImplementedError.new("APIResource is an abstract class. You should perform actions on its subclasses (i.e. Publisher)")
  	  end
  	  "/v1/"
  	end

    #Update All request to Version 1.
    def request(method='get', resource_url, params, body)
      TrustedSearch::api_version = 1
      super
    end

  	# Makes an API request to /directory-listings
  	# If uuid is nil, all are returned.
  	def getBusinessUpdate(uuid = nil)

  		method_url = 'directory-listings' + ( ( uuid ) ? "/#{uuid}" : '')
  		params = {}
  		return self.get(method_url, params)
  	end

    # Makes an API request to /directory-listings
    # Since is an integer, only changes made since that time are returned.
    def getBusinessUpdateSince( since )

      method_url = 'directory-listings'
      params = {}
      params[:since] = since
      return self.get(method_url, params)
    end

  	#Submit a single business more multiple business for
  	def postBusiness( data = [] )
  		method_url = 'local-business'
  		return self.post(method_url, {} , data )
    end
    #Validate a record.
    def postValidate( data = [] )
      method_url = 'validate'
      return self.post(method_url, {} , data )
    end

    def putTestFulfillment( uuid = nil)
      method_url = 'test-fulfillment/' + uuid.to_s
      return self.put(method_url)
    end
  end
end