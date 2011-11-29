require 'chronicle/roster_parser'

describe RosterParser do
  let (:parser) { RosterParser.new }
  let (:row) { "11/28/2011 13:32:01,Brian,39223-2,0,1,0,149,Henry Rollins,,,brianrady@gmail.com,Andoran,brianrady,,100,1,2,1".split(',') }
  let (:info) { parser.player_info(row) }

  it "extracts known columns from the line" do
    info[:player_name].should == 'Brian'
    info[:skype_id].should == 'brianrady'
  end

  it "Uses zero for a missing day job roll" do
    info[:day_job].should == 0
  end

  it "calculates net gold" do
    info[:subtotal].should == 249
    info[:gold_total].should == 249
  end

  it "calculates net prestige" do
    info[:final_prestige].should == 1
  end

  it "calculates net fame" do
    info[:final_fame].should == 3
  end

  it "calculates total_xp" do
    info[:xp_total].should == 1
  end

  it "splits the character ID into society and character number" do
    info[:society_number].should == '39223'
    info[:character_number].should == '2'
  end
end
