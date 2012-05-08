require 'chronicle/sheet_schema'

describe SheetSchema do
  before( :each ) do
    STDOUT.stub :puts
  end

  it "can find season zero 3 tier sheets" do
    schema = SheetSchema.find_schema(-8224746833)
    schema.keys.should include :chronicle_number
  end

  it "returns an empty schema if the sheet is not recognized" do
    STDERR.should_receive(:puts).with("Unrecognized sheet!")
    SheetSchema.find_schema(0).should == {}
  end
end
