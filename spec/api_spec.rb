require 'spec_helper'

describe "SmartThings::API" do

  describe ".server" do
    subject { SmartThings::API.new('12345').server(opts) }

    context "for ssl" do
      let(:opts) { { :use_ssl => true } }
      it "should be https" do
        subject.should == 'https://graph.api.smartthings.com'
      end
    end
    
    context "without ssl" do
      let(:opts) { { } }
      it "should be http" do
        subject.should == 'http://graph.api.smartthings.com'
      end
    end
  end


  describe ".api" do
    subject { SmartThings::API.new('12345') }

    

  end
end
