
require 'chronicle/settings'

describe Chronicle::Settings do
  before( :each ) do
    File.stub :exists?
    File.stub :open
  end

  it "it acts like a hash" do
    settings = Chronicle::Settings.new
    settings[:a] = 'a'
    settings[:a].should == 'a'
  end
end
