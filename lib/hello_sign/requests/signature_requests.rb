module HelloSign
  module Requests
    class SignatureRequests
      def self.list(params={})
        default_params = {
          :version => HelloSign::Client.api_version
        }

        params = default_params.merge!(params)

        route = HelloSign::Client.routes.route_for('signature-requests')
        url   = route.url_for(params)

        request = HelloSign::Client.connection.get do |req|
          req.url(url)
        end

        HelloSign::Response.new(request)
      end

      def self.retrieve(id, params={})
        default_params = {
          :version => HelloSign::Client.api_version
        }

        params = default_params.merge!(params)

        route = HelloSign::Client.routes.route_for('signature-request')
        url   = route.url_for(params.merge!(id: id))

        request = HelloSign::Client.connection.get do |req|
          req.url(url)
        end

        HelloSign::Response.new(request)
      end
    end
  end
end
