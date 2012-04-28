require 'java'

java_import javax.swing.JComponent
java_import java.awt.geom.AffineTransform

module Chronicle
  RH = java.awt.RenderingHints
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
      g.rendering_hints.put(RH::KEY_INTERPOLATION, RH::VALUE_INTERPOLATION_BICUBIC)
      g.rendering_hints.put(RH::KEY_ANTIALIASING, RH::VALUE_ANTIALIAS_ON)
      g.rendering_hints.put(RH::KEY_RENDERING, RH::VALUE_RENDER_QUALITY)
      scale = getWidth / 2513.0 
      g.transform(AffineTransform::getScaleInstance(scale, scale))
      @generator.render_sheet(@info, g)
    end
  end
end
