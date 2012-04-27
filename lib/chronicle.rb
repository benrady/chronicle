require 'java'
require 'fileutils'
require "chronicle/version"
require 'chronicle/sheet_renderer'
require 'chronicle/total_calculator'
require 'chronicle/sheet_schema'
require 'chronicle/gm_data'
require 'chronicle/gui'
require 'chronicle/basic_csv'

module Chronicle
  BI = java.awt.image.BufferedImage
  IO = javax.imageio.ImageIO
  XForm = java.awt.geom.AffineTransform

  def self.start
    g = Generator.new
    g.load_roster("test/roster.csv")
    g.load_sheet("test/Season3/3-FirstSteps3_AVisionOfBetrayal.png")
    Chronicle::GUI.new(g)
  end

  class Generator
    attr_accessor :roster

    def initialize
      @parser = TotalCalculator.new
    end

    def load_roster(roster_uri)
      lines = open(roster_uri).readlines
      @roster = []
      BasicCSV.new(lines).each do |row|
        @roster << @parser.player_info(row).merge(GMData.load_gm_data)
      end
    end
    
    def load_sheet(sheet_uri)
      @sheet = GMData.load(sheet_uri)
    end

    def render_sheet(info, g)
      renderer = SheetRenderer.new(g, SheetSchema.find(@sheet))
      g.drawImage(@sheet, nil, nil)
      renderer.draw(info)
      g.dispose
    end

    def write_sheet(sheet_image)
      player_dir = "#{output_dir}/#{info[:society_id]}"
      FileUtils.mkdir_p(player_dir)
      scenario_name = File.basename(chronicle_sheet, '.png')
      filename = "#{player_dir}/#{scenario_name}.png"
      write_sheet(sheet_image, filename)
    end

    def write_sheet(sheet, filename)
      IO.write(sheet, 'png', java.io.File.new(filename))
    end
  end
end
