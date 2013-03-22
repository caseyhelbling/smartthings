
module SmartThings


  class  API

    attr_reader :account_id

    def initialize(account_id = nil)
      @account_id = account_id
    end

    def clean(args)
      # turn all the keys to strings (Faraday has issues with symbols under 1.8.7) and resolve UploadableIOs
      args.inject({}) {|hash, kv| hash[kv.first.to_s] = kv.last.is_a?(UploadableIO) ? kv.last.to_upload_io : kv.last; hash}
    end

    def call(path, args = {}, verb = "get", options = {})

      result = SmartThings::Request.new(
        path, 
        clean(args), 
        verb, 
        options
      ).execute

      #[result.status.to_i, result.body, result.headers]
      #puts "RESULT: #{result}"

      #if result.status.to_i >= 500
        #raise "#{result.status.to_i} :: #{result.body}"
      #end
    
      # parse the body as JSON and run it through the error checker (if provided)
      MultiJson.load(result.body)
    end

    def data
      @response ||= call(end_point)
    end


  end

end
