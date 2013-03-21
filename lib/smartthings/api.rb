
module SmartThings

  class  API
    SERVER = "graph.api.smartthings.com"

    attr_reader :account_id

    def initialize(account_id = nil)
      @account_id = account_id
    end


    def server(options = {})
      server = SmartThings::API::SERVER
      "#{options[:use_ssl] ? "https" : "http"}://#{server}"
    end


    def api(path, args = {}, verb = "get", options = {})

      result = make_request(path, args, verb, options)

      if result.status.to_i >= 500
        raise "#{result.status.to_i} :: #{result.body}"
      end
    
      # parse the body as JSON and run it through the error checker (if provided)
      # Note: Facebook sometimes sends results like "true" and "false", which aren't strictly objects
      # and cause MultiJson.load to fail -- so we account for that by wrapping the result in []
      MultiJson.load("[#{result.body.to_s}]")[0]
    end

    def make_request(path, args, verb, options = {})
      # if the verb isn't get or post, send it as a post argument
      args.merge!({:method => verb}) && verb = "post" if verb != "get" && verb != "post"

      # figure out our options for this request
      request_options = {:params => (verb == "get" ? params : {})}.merge(http_options || {}).merge(process_options(options))
      #request_options[:use_ssl] = true 
      if request_options[:use_ssl]
        ssl = (request_options[:ssl] ||= {})
        ssl[:verify] = true unless ssl.has_key?(:verify)
      end

      # set up our Faraday connection
      # we have to manually assign params to the URL or the
      conn = Faraday.new(server(request_options), request_options, nil)

      response = conn.send(verb, path, (verb == "post" ? params : {}))

      # Log URL information
      puts "#{verb.upcase}: #{path} params: #{params.inspect}"
      [response.status.to_i, response.body, response.headers]
    end


    def graph_call(path, args = {}, verb = "get", options = {})
      result = api(path, args, verb, options) do |response|
        error = check_response(response[0], response[1])
        raise error if error
      end

      # now process as appropriate for the given call (get picture header, etc.)
      result 
    end
    

    def check_response(http_status, response_body)
      http_status = http_status.to_i

      if http_status >= 400
        begin
          response_hash = MultiJson.load(response_body)
        rescue MultiJson::DecodeError
          response_hash = {}
        end
      end
    end


  end

end
