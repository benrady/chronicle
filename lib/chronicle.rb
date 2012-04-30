require 'java'
require 'fileutils'
require "chronicle/version"
require 'chronicle/sheet_renderer'
require 'chronicle/total_calculator'
require 'chronicle/sheet_schema'
require 'chronicle/gm_data'
require 'chronicle/gui'
require 'chronicle/basic_csv'

java_import java.awt.image.BufferedImage
java_import javax.imageio.ImageIO
java_import javax.swing.JOptionPane

module Chronicle

  def self.start(*args)
    g = Generator.new
    g.load_roster(args[0]) if args.length > 0
    g.load_sheet(args[1]) if args.length > 1
    Chronicle::GUI.new(g)
  end

  # FIXME You should extract this out to a another file and see if you can test it
  class Generator
    attr_accessor :roster

    def initialize
      @parser = TotalCalculator.new
      @roster = []
    end

    def is_ready?
      @sheet and not @roster.empty?
    end

    def schema_name
      return @schema[:schema_name] if @schema
      "No Sheet Loaded"
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
      @schema = SheetSchema.find(@sheet)
      @scenario_name = File.basename(sheet_uri)
    end

    def render_sheet(info, g)
      if @sheet
        renderer = SheetRenderer.new(g, @schema)
        g.drawImage(@sheet, nil, nil)
        renderer.draw(info) if info
      else
        g.font = Font.new('Marker Felt', Font::PLAIN, 128)
        g.color = Color::LIGHT_GRAY
        g.drawString("Chronicle", 1000 , 750)
        g.drawString("v#{Chronicle::VERSION}", 1000, 900)
      end
    end

    def create_sheet_image(info)
      sheet_image = copy_image(@sheet)
      g = sheet_image.graphics
      render_sheet(info, g)
      g.dispose
      return sheet_image
    end

    def write_sheet(output_dir, info) 
      sheet_image = create_sheet_image(info)
      player_dir = File.join(output_dir, info[:society_number], info[:character_number] || "0") 
      FileUtils.mkdir_p(player_dir)
      filename = File.join(player_dir, @scenario_name)
      ImageIO.write(sheet_image, 'png', java.io.File.new(filename))
    end

    def write_sheets_to(output_dir)
      @roster.each do |info|
        write_sheet(output_dir, info)
      end
    end

    def copy_image(bi)
      cm = bi.color_model
      raster = bi.copyData(nil)
      return BufferedImage.new(cm, raster, cm.isAlphaPremultiplied, nil)
    end
  end
end
