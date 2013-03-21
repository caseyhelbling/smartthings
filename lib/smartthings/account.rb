require 'smartthings/api'


module SmartThings

  class Account < API
    #END_POINT = "api/accounts/:id"
    END_POINT = "api/accounts/"

    attr_accessor :account_id
    def initialize(account_id)
      @account_id = account_id
    end

    def name
    end

    def full_name
    end

    def locked
    end

    def locations
      #https://graph.api.smartthings.com/api/accounts/:id/locations
      #[{
          #"id": "402881853a55b643013a55ba18d80000",
          #"name": "Home",
          #"accountId": "7fc6bb67-c336-4114-98d8-b198016dcd48",
          #"latitude": "",
          #"longitude": "",
          #"regionRadius": "",
          #"backgroundImage": "https://smartthings-location-images.s3.amazonaws.com/standard/standard1.png",
          #"mode": {
              #"id": "c88c902e-2ed4-11e2-b536-1a6bcdc263a7",
              #"name": "Away"
          #},
          #"modes": [
              #{
                  #"id": "c88c902e-2ed4-11e2-b536-1a6bcdc263a7",
                  #"name": "Away"
              #},
              #{
                  #"id": "c88c826e-2ed4-11e2-b536-1a6bcdc263a7",
                  #"name": "Home"
              #},
              #{
                  #"id": "c88c9d4e-2ed4-11e2-b536-1a6bcdc263a7",
                  #"name": "Night"
              #}
          #]
      #}]
    end

    def roles
      #https://graph.api.smartthings.com/api/accounts/:id/roles
      #[{
              #"email": "foo@bar.com",
              #"role": "owner"
          #},
          #{
              #"email": "bar@baz.com",
              #"role": "owner"
          #}]
    end

    def events
      #https://graph.api.smartthings.com/api/accounts/:id/events
    end

  end
end


