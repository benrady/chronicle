require 'java'
require 'fileutils'
require 'chronicle/sheet_renderer'
require 'chronicle/total_calculator'
require 'chronicle/sheet_schema'
require 'chronicle/resources'
require 'chronicle/basic_csv'
require "chronicle/version"

java_import java.awt.image.BufferedImage
java_import javax.imageio.ImageIO
java_import javax.swing.JOptionPane

class ValidationError < Exception
  def initialize(validation_errors)
    @validation_errors = validation_errors
  end
end

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
    lines = File.open(roster_uri).readlines
    @roster = []
    BasicCSV.new(lines).each do |row|
      validation = @parser.validate(row)
      raise ValidationError.new(validation) unless validation.empty?
      @roster << @parser.calculate_totals(row).merge(Resources.load_gm_data)
    end
  end

  def load_sheet(sheet_uri)
    @sheet = Resources.load_image(sheet_uri)
    puts @sheet.getType
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
    player_dir = File.join(output_dir, info[:society_number])
    FileUtils.mkdir_p(player_dir)
    filename = File.join(player_dir, "#{info[:character_name]}-#{@scenario_name}")
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
