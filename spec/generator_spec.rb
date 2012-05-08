require 'chronicle/generator.rb'

describe Generator do
  let (:generator) { Generator.new }
  let (:roster_file) { double 'roster file' }

  it "detects invalid roster files" do
    missing_day_job = "timestamp,player_name,character_name,gold_gained,xp_gained,prestige_gained,prestige_spent,society_id,starting_xp,starting_fame,starting_prestige,starting_gold,buy_list,sell_list,faction,gm_society_number,chronicle_number,event_code,event"
    roster_file.stub(:readlines).and_return [
      missing_day_job,
      "4/14/2012 16:58:29,brianrady,Slayrn,3460,1,2,0,39223-6,15,,,,,,Taldor,5,38803,13,9333,WCPFS Nightowls"
    ]
    File.should_receive(:open).and_return roster_file

    Proc.new { generator.load_roster("roster.csv") }.should raise_error "Invalid Roster File"
  end

  it "gets the list of available sheets" do
    generator.available_sheets.should include(
      "3-EX FirstSteps 1 - In Service To Lore" => "resources/sheets/3-EX FirstSteps 1 - In Service To Lore.png"
    )
  end
end
