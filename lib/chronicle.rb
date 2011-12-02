require 'java'
require "chronicle/version"
require 'chronicle/sheet_renderer'
require 'chronicle/total_calculator'
require 'chronicle/sheet_schema'
require 'chronicle/gm_data'
require 'chronicle/basic_csv'

module Chronicle
  BI = java.awt.image.BufferedImage
  IO = javax.imageio.ImageIO

  def self.write_sheet(sheet, player_name)
    IO.write(sheet, 'png', java.io.File.new("sheets/#{player_name}.png"))
  end

  def self.detect_schema(g)
    # Should be able to detect the schema based on the color of a few key pixels.
    SheetSchema::Season3::TWO_TIER
  end

  def self.finish(chronicle_number, event_name, event_code)
    parser = TotalCalculator.new
    BasicCSV.parse_lines(STDIN.readlines).each do |row|
      sheet = GMData.load_chronicle_sheet
      g = sheet.getGraphics
      renderer = SheetRenderer.new(g, detect_schema(g))
      info = parser.player_info(row).merge(GMData.load_gm_data)
      renderer.draw(info)
      g.dispose
      write_sheet(sheet, info[:player_name])
    end
  end
end
