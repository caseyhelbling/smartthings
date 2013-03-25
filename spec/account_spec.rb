require 'spec_helper'
require 'ruby-debug'

describe "SmartThings::Account" do

  describe "name" do
    subject { SmartThings::Account.new('8a9f19b33d460fc2013d46e5d473009f') }

    before do
    end

    it "should get account name" do
      subject.name.should == 'casey@softwareforgood.com\'s Account'
    end
  end

end

