module TrustedSearch
  module V2
    class HookSubscription < ApiVersion2
      attr_accessor :resource

      def initialize
        @resource = 'hook-subscriptions'
      end
      

      def all()
        method_url = @resource
        return self.get(method_url)
      end

      #Get the details of a single hook
      def show(id = nil)
        method_url = @resource + "/" + id
        params = {}
        return self.get(method_url, params)
      end

      def add(data = nil)
        method_url = @resource
        params = {}
        return self.post(method_url, params, data)
      end

      def edit(id = nil, data)
        method_url = @resource + "/" + id
        params = {}
        return self.put(method_url, params, data)
      end

      def destroy(id = nil)
        method_url = @resource + "/" + id
        return self.delete(method_url)
      end

    end
  end
end