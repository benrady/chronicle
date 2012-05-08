require 'chronicle/resources'

describe Resources do
  it "gives you the list of available resources" do
    STDERR.stub :puts
    Resources.list_resources.should include("resources/sheets/3-EX FirstSteps 1 - In Service To Lore.png")
  end

  it "can load a resources from the disk" do
    Resources.load_resource("resources/sheets/3-EX FirstSteps 1 - In Service To Lore.png").should_not == nil
  end

  it "can tell if we're running from a jar file" do
    Resources.running_in_jar?.should == false
  end
end
