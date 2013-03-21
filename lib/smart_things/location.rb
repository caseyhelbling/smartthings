
module SmartThings

  class Location < API

    #END_POINT = /api/accounts/:id/locations

    attr_accessor :location_id
    def initialize(account_id, location_id)
      super(account_id)
      @location_id = location_id
    end


  end
end


