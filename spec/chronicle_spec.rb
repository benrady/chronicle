require 'chronicle'

describe Chronicle do
  let (:generator) { double 'generator' }

  before( :each ) do
    Generator.stub(:new).and_return generator
  end

  it "Starts a GUI" do
    GUI.should_receive(:new).with(generator)
    Chronicle.start
  end

  it "loads a roster if provided as args" do
    GUI.stub :new
    generator.should_receive(:load_roster).with("foo.csv")

    Chronicle.start("foo.csv")
  end

  it "loads a sheet if provided as args" do
    GUI.stub :new
    generator.stub :load_roster
    generator.should_receive(:load_sheet).with("scenario.png")

    Chronicle.start("foo.csv", "scenario.png")
  end
end
