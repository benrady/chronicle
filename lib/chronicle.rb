require "chronicle/version"
require 'java'
require 'chronicle/sheet_renderer'
require 'chronicle/roster_parser'

module SheetSchema
  module Season2
    TWO_TIER = {}
    THREE_TIER = {}
  end

  module Season3
    TWO_TIER = {
      :player_name => [:text, [149, 600]],
      :character_name => [:text, [672, 600]],
      :society_number => [:text, [1175, 600]],
      :character_number => [:text, [1472, 600]],
      :faction => [:text, [1680, 600]],
      :chronicle_number => [:text, [2012, 255]],
      :slow => [:check, [2115, 333]],
      :normal => [:check, [2240, 333]],
      :starting_xp => [:text, [2012, 790]],
      :xp_gained => [:text, [2055, 928]],
      :xp_total => [:text, [2012, 1067]],
      :starting_fame => [:text, [2012, 1325]],
      :starting_prestige => [:text, [2196, 1325]],
      :prestige_gained => [:text, [2055, 1464]],
      :prestige_spent => [:text, [2055, 1602]],
      :final_fame => [:text, [2012, 1740]],
      :final_prestige => [:text, [2196, 1740]],
      :starting_gold => [:text, [2012, 1979]],
      :gold_gained => [:text, [2055, 2117]],
      :day_job => [:text, [2055, 2256]],
      :items_sold_total => [:text, [2055, 2395]],
      :subtotal => [:text, [2055, 2532]],
      :items_bought_total => [:text, [2055, 2670]],
      :gold_total => [:text, [2055, 2829]],
      :event => [:text, [174, 3054]],
      :event_code => [:text, [538, 3054]],
      :date => [:text, [926, 3054]],
      :gm_signature => [:image, [1304, 3054]],
      :gm_society_number => [:text, [1914, 3054]],
      :items_sold_desc => [:list, {
        :coords => [181,2539],
        :height => 2571-2539,
        :size => 7
      }],
      :items_sold_amount => [:list, {
        :coords => [795,2539],
        :height => 2571-2539,
        :size => 7
      }]
    }
    THREE_TIER = {}
  end
end

module Chronicle
  BI = java.awt.image.BufferedImage
  CS = java.awt.color.ColorSpace
  IO = javax.imageio.ImageIO

  def self.gm_info
    {
      :gm_society_number => '38803',
      :date => Time.new.strftime("%D"),
      :event_code => '12345',
      :event => "WCPFS"
    }
  end

  def self.finish
    file = java.io.File.new('chronicle_sheet.png')
    parser = RosterParser.new
    while line=STDIN.gets do
      bi = IO.read(file)
      g = bi.getGraphics
      renderer = SheetRenderer.new(g,SheetSchema::Season3::TWO_TIER)
      info = parser.player_info(line).merge(gm_info)
      renderer.draw(info)
      g.dispose
      IO.write(bi, 'png', java.io.File.new("#{info[:player_name]}.png"))
    end
  end
end
