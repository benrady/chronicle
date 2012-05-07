require 'chronicle/generator.rb'

describe Generator do
  let (:generator) { Generator.new }
  let (:roster_file) { double 'roster file' }

  it "can detect errors in a roster file" do
    roster_file.stub(:readlines).and_return [
      "header1,header2",
      "row1,row2"
    ]
    File.should_receive(:open).and_return roster_file

    Proc.new{generator.load_roster("myroster.csv")}.should raise_error ValidationError
    generator.roster.should == []
  end
  
end
