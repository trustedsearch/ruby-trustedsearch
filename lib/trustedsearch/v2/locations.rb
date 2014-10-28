module TrustedSearch
  module V2
    class Location < ApiVersion2
      attr_accessor :resource

      def initialize
        @resource = 'locations'
      end

      #Retrieve an array of all available hooks
      def index()
        method_url = @resource
        return self.get(method_url)
      end

      #Get the details of a single hook
      def listings(location_id = nil)
        method_url = @resource + "/" + location_id + "/listings"
        params = {}
        return self.get(method_url, params)
      end

    end
  end
end