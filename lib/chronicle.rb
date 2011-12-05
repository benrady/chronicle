require 'java'
require 'fileutils'
require "chronicle/version"
require 'chronicle/sheet_renderer'
require 'chronicle/total_calculator'
require 'chronicle/sheet_schema'
require 'chronicle/gm_data'
require 'chronicle/basic_csv'

module Chronicle
  BI = java.awt.image.BufferedImage
  IO = javax.imageio.ImageIO

  def self.write_sheet(sheet, filename)
    IO.write(sheet, 'png', java.io.File.new(filename))
  end

  def self.detect_schema(g)
    # Should be able to detect the schema based on the color of a few key pixels.
    SheetSchema::Season3::TWO_TIER
  end

  def self.finish(roster_file, scenario_name, output_dir='sheets')
    parser = TotalCalculator.new
    puts lines = open(roster_file).readlines
    BasicCSV.new(lines).each do |row|
      sheet = GMData.load_chronicle_sheet
      g = sheet.getGraphics
      renderer = SheetRenderer.new(g, detect_schema(g))
      info = parser.player_info(row).merge(GMData.load_gm_data)
      renderer.draw(info)
      g.dispose
      player_dir = "#{output_dir}/#{info[:society_id]}"
      FileUtils.mkdir_p(player_dir)
      puts "Generating #{player_dir}"
      filename = "#{player_dir}/#{scenario_name}.png"
      write_sheet(sheet, filename)
    end
  end
end
