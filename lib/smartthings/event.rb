require 'smartthings/api'

module SmartThings

  class Event < API

    #END_POINT = /api/accounts/:id/events
    
    attr_accessor :location_id
    def initialize(location_id)
      @location_id = location_id
    end

    def name
    end

  end
end

