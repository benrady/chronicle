require 'java'
require "chronicle/version"
require 'chronicle/sheet_renderer'
require 'chronicle/roster_parser'
require 'chronicle/sheet_schema'
require 'chronicle/gm_data'
require 'chronicle/basic_csv'

module Chronicle
  BI = java.awt.image.BufferedImage
  IO = javax.imageio.ImageIO

  def self.write_sheet(sheet, player_name)
    IO.write(sheet, 'png', java.io.File.new("sheets/#{player_name}.png"))
  end

  def self.finish(chronicle_number, event_name, event_code)
    parser = RosterParser.new
    BasicCSV.parse_lines(STDIN.readlines).each do |line|
      sheet = GMData.load_chronicle_sheet
      g = sheet.getGraphics
      renderer = SheetRenderer.new(g, SheetSchema::Season3::TWO_TIER)
      info = parser.player_info(line).merge({
        :chronicle_number => chronicle_number,
        :event_code => event_code,
        :event => event_name
      }).merge(GMData.load_gm_data)
      renderer.draw(info)
      g.dispose
      write_sheet(sheet, info[:player_name])
    end
  end
end
