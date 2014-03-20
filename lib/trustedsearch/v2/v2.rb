module TrustedSearch
	module V2
		class ApiVersion2 < Api
			def base_path
			  if self == APIResource
			    raise NotImplementedError.new("APIResource is an abstract class. You should perform actions on its subclasses (i.e. Publisher)")
			  end
			  "/v2/"
			end
		end
	end
end