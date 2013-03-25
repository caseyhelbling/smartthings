module SmartThings

  class Request

    def initialize(path, clean_params, verb, options={})
      @path = path
      @clean_params = clean_params 
      @verb = verb
      @options = options
    end

    def server(dont_use_ssl = false)
      # figure out different envs
      "#{dont_use_ssl ? "http" : "https"}://#{SmartThings::HOST}"
    end
    
    def self.connection(server, opts)
      #if request_options[:use_ssl]
        #ssl = (request_options[:ssl] ||= {})
        #ssl[:verify] = true unless ssl.has_key?(:verify)
      #end

      Faraday.new(server, opts, &SmartThings::DEFAULT_MIDDLEWARE)
    end

    def connection
      @connection ||= self.class.connection(server(@options[:use_ssl]), @options)
    end


    def execute
      # if the verb isn't get or post, send it as a post argument
      #unless ['get', 'post'].include?(@verb)
        #@verb = "post" 
        #@clean_params.merge!({:method => @verb})
      #end

      response = case @verb
        when 'get' then connection.get(@path)#, @clean_params)
        when 'post' then connection.post(@path)#, @clean_params)
        else
      end

      # Log URL information
      SmartThings.logger.info "#{@verb.upcase}: #{@path} params: #{@clean_params.inspect}"
      SmartThings.logger.info "response: \n\t::\t#{response.body}"

      response
    end

  end

end
