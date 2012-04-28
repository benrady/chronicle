
require 'chronicle/settings'

describe Chronicle::Settings do
  it "it acts like a hash" do
    settings = Chronicle::Settings.new
    settings[:a] = 'a'
    settings[:a].should == 'a'
  end
end
