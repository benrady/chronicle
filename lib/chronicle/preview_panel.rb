require 'java'

java_import javax.swing.JComponent
java_import java.awt.geom.AffineTransform

module Chronicle
  class PreviewPanel < JComponent 
    def initialize(generator)
      super()
      @generator = generator
    end
    
    def info=(info)
      @info = info
      repaint
    end

    def paintComponent(g)
      g = g.create # Make a copy that we can safely mess with
      scale = getWidth / 2513.0 # FIXME  Should use a fixed scale and adjust the component size
      #2513x3263
      # g.transform(AffineTransform::getTranslateInstance(100, 100))  I think this needs a shift to display correctly
      g.transform(AffineTransform::getScaleInstance(scale, scale))
      @generator.render_sheet(@info, g)
    end
  end
end
