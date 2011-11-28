require 'java'

import java.awt.Color
import java.awt.Font
class SheetRenderer
  def initialize(graphics, schema)
    @g, @schema = graphics, schema
    @g.setColor Color.black
    @g.setFont(Font.new('Serif', Font::PLAIN, 36))
  end
  
  def draw(player_info)
    player_info.keys.each do |key|
      if @schema.has_key? key
        type, markup = @schema[key] 
        value = player_info[key]
        render_method = "draw_#{type}".to_sym
        if respond_to? render_method
          send(render_method, value, markup)
        else
          STDERR.puts "Unknown field type '#{type}' in schema"
        end
      end
    end
  end

  def draw_text(text, markup)
    x, y = markup
    @g.drawString(text.to_s, x, y)
  end

  def draw_list(list, markup)
    x, y = markup[:coords]
    markup[:size].times do |row|
      @g.drawString(list[row].to_s, x, y + (row * markup[:height]))
    end
  end
end
