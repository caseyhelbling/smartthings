
module SmartThings


  DEFAULT_MIDDLEWARE = Proc.new do |faraday|
    builder.request :url_encoded
    faraday.response :json
    builder.adapter Faraday.default_adapter
  end

  class Request

    def initialize(path, args, verb, options={})
      @path = path
      @args = args
      @verb = verb
      @options = options
    end

    def clean(args)
      # turn all the keys to strings (Faraday has issues with symbols under 1.8.7) and resolve UploadableIOs
      args.inject({}) {|hash, kv| hash[kv.first.to_s] = kv.last.is_a?(UploadableIO) ? kv.last.to_upload_io : kv.last; hash}
    end
    

    def connection
      if request_options[:use_ssl]
        ssl = (request_options[:ssl] ||= {})
        ssl[:verify] = true unless ssl.has_key?(:verify)
      end

      # set up our Faraday connection
      Faraday.new(
        server(request_options[:use_ssl]), 
        request_options, 
        &SmartThings::DEFAULT_MIDDLEWARE
      )
    end

    def execute
      # if the verb isn't get or post, send it as a post argument
      unless ['get', 'post'].include?(@verb)
        @verb = "post" 
        @args.merge!({:method => @verb})
      end

      params = clean(@args)

      response = connection.send(@verb, @path, params)

      # Log URL information
      puts "#{@verb.upcase}: #{@path} params: #{params.inspect}"
      [response.status.to_i, response.body, response.headers]
    end

  end

  class  API
    SERVER = "graph.api.smartthings.com"

    attr_reader :account_id

    def initialize(account_id = nil)
      @account_id = account_id
    end

    def server(use_ssl=false)
      "#{use_ssl ? "https" : "http"}://#{SmartThings::API::SERVER}"
    end


    def call(path, args = {}, verb = "get", options = {})

      result = SmartThings::Request.new(path, args, verb, options).execute

      puts "RESULT: #{result}"

      if result.status.to_i >= 500
        raise "#{result.status.to_i} :: #{result.body}"
      end
    
      # parse the body as JSON and run it through the error checker (if provided)
      MultiJson.load(result.body)
    end

  end

end
