module SmartThings

  class Request

    def initialize(path, clean_params, verb, options={})
      @path = path
      @clean_params = clean_params 
      @verb = verb
      @options = options
    end

    def server(use_ssl=false)
      # figure out different envs
      "#{use_ssl ? "https" : "http"}://#{SmartThings::HOST}"
    end
    
    def self.connection
      #if request_options[:use_ssl]
        #ssl = (request_options[:ssl] ||= {})
        #ssl[:verify] = true unless ssl.has_key?(:verify)
      #end

      Faraday.new(
        server(@options[:use_ssl]), 
        @options, 
        &SmartThings::DEFAULT_MIDDLEWARE
      )
    end

    def connection
      @connection ||= self.class.connection
    end


    def execute
      # if the verb isn't get or post, send it as a post argument
      #unless ['get', 'post'].include?(@verb)
        #@verb = "post" 
        #@clean_params.merge!({:method => @verb})
      #end

      response = case @verb
        when 'get' then connection.get(@path, params)
        when 'post' then connection.post(@path, params)
        else
      end

      # Log URL information
      #puts "#{@verb.upcase}: #{@path} params: #{params.inspect}"
      response
    end

  end

end
