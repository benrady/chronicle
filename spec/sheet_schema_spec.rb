require 'chronicle/sheet_schema'

describe SheetSchema do
  BI = java.awt.image.BufferedImage
  let(:image) { BI.new(2513, 3263, BI::TYPE_INT_RGB) }

  before( :each ) do
    @g = image.createGraphics
    @g.setColor(Color.red)
    @g.fillRect(0, 0, 2513, 3263)
  end

  it "detects season two, three tier sheets" do
    @g.setColor(Color.black)
    @g.fillRect(2045, 520, 1, 1)
    SheetSchema.find(image).should == SheetSchema::season2[:three_tier]
  end

  it "detects season three, two tier sheets" do
    @g.setColor(Color.white)
    @g.fillRect(2045, 520, 1, 1)
    SheetSchema.find(image).should == SheetSchema.season3[:two_tier]
  end

  it "includes the GM info fields" do
    SheetSchema.season2[:three_tier][:gm_society_number].should_not be nil
    SheetSchema.season3[:two_tier][:gm_society_number].should_not be nil
  end
  
end
