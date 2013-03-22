require 'spec_helper'

describe "SmartThings::Account" do

  describe "name" do
    subject { SmartThings::Account.new('8a9f19b33d460fc2013d46e5d473009f') }

    before do
      #req = stub(:request)
    end

    it "should get account name" do
      subject.name.should == 'casey@softwareforgood.com\'s Account'
    end
  end

end

