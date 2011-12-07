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

  def self.generate(roster_file, chronicle_sheet=nil, output_dir='sheets')
    parser = TotalCalculator.new
    lines = open(roster_file).readlines
    BasicCSV.new(lines).each do |row|
      if chronicle_sheet
        info = parser.player_info(row).merge(GMData.load_gm_data)
        sheet = GMData.load(chronicle_sheet)
        exit 1 unless sheet
        g = sheet.getGraphics
        renderer = SheetRenderer.new(g, SheetSchema.find(sheet))
        renderer.draw(info)
        g.dispose
        player_dir = "#{output_dir}/#{info[:society_id]}"
        FileUtils.mkdir_p(player_dir)
        scenario_name = File.basename(chronicle_sheet, '.png')
        filename = "#{player_dir}/#{scenario_name}.png"
        puts "Generating #{filename}"
        write_sheet(sheet, filename)
      else
        puts row.inspect
      end
    end
  end
end
