module Salsify
  module Auth
    class Token < Base

      attr_reader :secret_key

      def initialize(secret_key = ENV['STEAM_API_KEY'])
        @secret_key = secret_key
        raise(ArgumentError, 'Secret key not found.') if @secret_key.nil?
      end

      def auth_headers
        {
            'key' => @secret_key
        }
      end

    end
  end
end
