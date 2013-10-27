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

  	# Makes an API request to /directory-listings
  	# If uuid is nil, all are returned.
  	# If since is provided as an integer, only changes made since that time are returned.
  	def getBusinessUpdate(uuid = nil , since = nil)
  		method_url = 'directory-listings' + ( (uuid) ? "/#{uuid}" : '')
  		params = {}
  		if(since)
  			params[:since] = since
  		end

  		return self.get(method_url, params)
  	end

  	#Submit a single business more multiple business for
  	def postBusiness( data = [] )
  		method_url = 'local-business'
  		return self.post(method_url, {} , data )
  	end


    def putTestFulfillment( uuid = nil)
      method_url = 'test-fulfillment/' + uuid.to_s
      return self.put(method_url)
    end
  end
end