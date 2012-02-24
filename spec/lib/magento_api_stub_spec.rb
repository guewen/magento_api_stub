require 'spec_helper'

describe MagentoAPIStub do
  it "should say hello" do
    MagentoAPIStub::Server.new.test.should == "hello"
  end
end
