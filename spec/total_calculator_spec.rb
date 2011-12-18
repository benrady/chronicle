require 'chronicle/total_calculator'

describe TotalCalculator do
  let (:parser) { TotalCalculator.new }
  let (:row) {{
    :timestamp => "11/28/2011 13:32:01",
    :player_name => "Brian",
    :society_id => '39223-2',
    :starting_xp => '0',
    :starting_fame => '1',
    :starting_prestige => '0',
    :starting_gold => '149',
    :character_name => 'Henry Rollins',
    :buy_list => '',
    :sell_list => '',
    :email_address => 'brianrady@gmail.com',
    :faction => 'Andoran',
    :day_job => '', 
    :gold_gained => '100',
    :xp_gained => '1',
    :prestige_gained => '2',
    :prestige_spent => '1',
    :gm_society_number => '38803',
    :chronicle_number => '1',
    :event_code => '9333',
    :event => 'WCPFS'
  }}
  let (:info) { parser.player_info(row) }

  it "extracts known columns from the line" do
    info[:player_name].should == 'Brian'
    info[:email_address].should == 'brianrady@gmail.com'
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

  describe "when totaling up items bought or sold" do
    it "allows a leading amount" do
      result = parser.parse_items("3 potions of cure light wounds 50gp")
      descriptions, amounts, total = result
      descriptions.first.should == '3 portions of cure light wounds'
      amounts.first.should == 50
      total.should == 50
    end
  end

  describe "when items are bought and sold" do
    let (:info) {{
      :buy_list => "first item 20gp\nsecond item 30 sp\nitem 10PP",
      :sell_list => "other item 10gp\nanother item 15 gp"
    }}

    before( :each ) do
      parser.parse_trades(info)
    end

    it "parses the items from a single string" do
      info[:items_bought_desc].should == ['first item', 'second item', 'item']
      info[:items_sold_desc].should == ['other item', 'another item']
    end
    
    it "calculates the total" do
      info[:items_bought_cost].should == 123
      info[:items_sold_cost].should == 25
      info[:items_bought_total].should == 123
      info[:items_sold_total].should == 12
    end
    
    it "warns if items are not property formatted" do
      info[:buy_list] = "not an item"
      STDERR.should_receive(:puts).with /not an item/
      parser.parse_trades(info)
    end
  end
end
