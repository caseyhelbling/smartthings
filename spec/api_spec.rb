require 'spec_helper'

describe "SmartThings::API" do

  describe ".api" do
    subject { SmartThings::API.new('12345') }

    before do
      req = stub(:request)
      req.should_receive(:execute).and_return(
        stub(:body => "{\"account\":{\"id\":\"someid\",\"name\":\"casey@softwareforgood.com's Account\"}}")
      )
      SmartThings::Request.stub(:new).and_return(req)

    end

    it "should make requests" do
      response = subject.call('/api/accounts')
      #puts response
      response['account']['id'].should == 'someid'
    end 

  end
end
