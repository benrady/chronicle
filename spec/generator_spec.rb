require 'chronicle/generator.rb'

describe Generator do
  let (:generator) { Generator.new }
  let (:roster_file) { double 'roster file' }

  it "can validate a roster file" do
    pending
    roster_file.stub(:readlines).and_return [
    "timestamp,player_name,character_name,gold_gained,xp_gained,prestige_gained,prestige_spent,society_id,starting_xp,starting_fame,starting_prestige,starting_gold,buy_list,sell_list,faction,gm_society_number,chronicle_number,event_code,event",
    "4/14/2012 16:58:29,brianrady,Slayrn,3460,1,2,0,39223-6,15,,,,,,Taldor,5,38803,13,9333,WCPFS Nightowls"
    ]
    File.should_receive(:open).and_return roster_file

    generator.load_roster("roster.csv")
    generator.validate.should == ["Missing column day_job"]
  end
  
end
