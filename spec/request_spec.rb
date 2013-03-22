require 'spec_helper'

describe "SmartThings::Request" do

  describe ".server" do
    subject { SmartThings::Request.new('/foo', {}, 'get').server(use_ssl) }

    context "for ssl" do
      let(:use_ssl) { true  }
      it "should be https" do
        subject.should == 'https://graph.api.smartthings.com'
      end
    end
    
    context "without ssl" do
      let(:use_ssl) { nil  }
      it "should be http" do
        subject.should == 'http://graph.api.smartthings.com'
      end
    end
  end

end
