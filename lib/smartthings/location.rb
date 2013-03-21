require 'smartthings/api'

module SmartThings

  class Location < API

    #END_POINT = /api/accounts/:id/locations

    attr_accessor :location_id
    def initialize(location_id)
      @location_id = location_id
    end


  end
end


