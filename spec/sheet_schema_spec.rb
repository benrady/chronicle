require 'chronicle/sheet_schema'

describe SheetSchema do
  it "can find season zero 3 tier sheets" do
    STDOUT.stub :puts
    schema = SheetSchema.find_schema(-8224746833)
    schema.keys.should include :chronicle_number
  end

  it "can find other sheets" do
    pending
  end
end
