require 'chronicle/sheet_renderer'

describe SheetRenderer do
  let (:graphics) { double 'graphics' }
  let (:schema_doc) { {} }
  let (:renderer) { SheetRenderer.new(graphics, schema_doc) }

  before( :each ) do
    graphics.stub :setColor
    graphics.stub :setFont
  end

  it "draws text info on the sheet" do
    schema_doc[:name] = [:text, [10, 15]]
    graphics.should_receive(:setFont)
    graphics.should_receive(:setColor).with(Color.black)
    graphics.should_receive(:drawString).with("Bob", 10, 15)
    renderer.draw({:name => 'Bob'})
  end

  it "prints an error if the schema uses an unknown field type" do
    STDERR.should_receive(:puts).with /Unknown field type 'fake'/
    schema_doc[:name] = [:fake, {}]
    renderer.draw({:name => 'Bob'})
  end

  it "draws lists with markup to align them" do
    schema_doc[:items] = [:list, {
      :coords => [10, 15],
      :height => 10,
      :size => 3
    }]

    graphics.should_receive(:drawString).with("one", 10, 15)
    graphics.should_receive(:drawString).with("two", 10, 25)
    graphics.should_receive(:drawString).with("three", 10, 35)
    renderer.draw({:items => ['one', 'two', 'three']})
  end

end
