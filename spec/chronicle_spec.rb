require 'chronicle'

describe Chronicle do
  it "Starts a GUI" do
    GUI.should_receive :new
    Chronicle.start
  end
end
