module DotaProf
  class RequestHandler

    def initialize
      @app_root = API_ROOT

      @retry = retry
      @retry_limit = @retry ? 1 : 0

      @auth = auth || DotaProf::Auth::Base.new
    end

    def get(path, body: nil, params: nil, headers: {})
      prepared_headers = request_headers(headers)
      with_request_retry do
        RestClient.get(url(path), prepared_headers, &response_wrapper)
      end
    end

    private

    def with_request_retry
      @retries = 0
      begin
        yield
      rescue RestClient::Exception
        raise unless @retries < @retry_limit
        @auth_retries += 1
        retry
      end
    end

    def request_headers(headers)
      FIXED_HEADERS.merge(auth.auth_headers).merge(headers)
    end

    def url(path)
      "#{@app_root}#{path}"
    end

  end
end