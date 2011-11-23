require "chronicle/version"
require 'java'

import java.awt.Color
import java.awt.Font

class Schema
  def initialize(schema)
    @schema = schema
  end

  def draw(g, player_info)
    g.setColor Color.black
    g.setFont(Font.new('Serif', Font::PLAIN, 36))
    @schema.keys.each do |key|
      x,y = @schema[key]
      value = player_info[key]
      g.drawString(value.to_s, x, y)
    end
  end

end

module Chronicle
  BI = java.awt.image.BufferedImage
  CS = java.awt.color.ColorSpace
  IO = javax.imageio.ImageIO

  def self.schema
    {
      "gm_society_number" => [1010, 1520],
      "date" => [486, 1520],
      "event_code" => [293, 1520],
      "event_name" => [100, 1520],
    }
  end

  def self.create_document
    file = java.io.File.new('test.png')
    bi = IO.read(file)
    sheet_schema = Schema.new schema
    player_info = {
      :gm_society_number => '38803',
      :date => Time.new.strftime("%D"),
      :event_code => '12345',
      :event_name => "WCPFS",
    }
    g = bi.getGraphics
    sheet_schema.draw(g, player_info)
    g.dispose
    IO.write(bi, 'png', java.io.File.new('output.png'))
  end
end
