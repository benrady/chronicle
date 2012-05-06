require 'java'
require 'fileutils'
require 'chronicle/gui'
require 'chronicle/generator'

java_import java.awt.image.BufferedImage
java_import javax.imageio.ImageIO
java_import javax.swing.JOptionPane

module Chronicle
  def self.start(*args)
    g = Generator.new
    g.load_roster(args[0]) if args.length > 0
    g.load_sheet(args[1]) if args.length > 1
    GUI.new(g)
  end
end
