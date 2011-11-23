require 'chronicle'

describe Schema do
  let (:graphics) { double 'graphics' }

  let (:schema) do 
    Schema.new({"name" => [10, 15]})
  end

  before( :each ) do
    graphics.stub :setColor
    graphics.stub :setFont
  end

  it "draws the player info on top of the sheet" do
    graphics.should_receive(:drawString).with("Bob", 10, 15)
    schema.draw(graphics, {"name" => 'Bob'})
  end

  it "draws the GM info on top of the sheet" do
    pending
  end

  it "digitally signs the player info" do
    pending
  end
end
