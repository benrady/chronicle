
require 'chronicle/settings'

describe Settings do
  before( :each ) do
    File.stub :exists?
    File.stub :open
  end

  it "it acts like a hash" do
    settings = Settings.new
    settings[:a] = 'a'
    settings[:a].should == 'a'
  end

  it "saves the settings to disk"
end
