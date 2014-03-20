module TrustedSearch
  module V2
    class Hook < ApiVersion2
      attr_accessor :resource

      def initialize
        @resource = 'hooks'
      end
      
      #Retrieve an array of all available hooks
      def index()
        method_url = @resource
        return self.get(method_url)
      end

      #Get the details of a single hook
      def show(id = nil)
        method_url = @resource + "/" + id
        params = {}
        return self.get(method_url, params)
      end

    end
  end
end