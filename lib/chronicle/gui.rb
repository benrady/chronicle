require 'java'

java_import javax.swing.JLabel
java_import javax.swing.JPanel
java_import javax.swing.JComponent
java_import javax.swing.JComboBox
java_import javax.swing.Box
java_import javax.swing.BoxLayout
java_import javax.swing.BorderFactory
java_import javax.swing.border.BevelBorder
java_import java.awt.BorderLayout
java_import java.awt.FlowLayout
java_import java.awt.GridLayout
java_import java.awt.Color
java_import java.awt.Dimension

# FIXME Todo:
# Import roster from GUI via FileChooser
# Select Chronicle Sheet using FileChooser

module Chronicle
  class PreviewPanel < JComponent 
    def initialize(generator, info)
      super()
      @generator = generator
      @info = info
      border = BorderFactory::createBevelBorder(BevelBorder::LOWERED)
      preferredSize = Dimension.new(640, 0)
    end

    def paintComponent(g)
      g = g.create # Make a copy that we can safely mess with
      scale = getWidth / 2513.0 # FIXME  Should use a fixed scale and adjust the component size
      g.transform(XForm::getScaleInstance(scale, scale))
      @generator.render_sheet(@info, g)
    end
  end

  class GUI 
    def initialize(generator)
      @generator = generator
      @frame = create_frame
      content = @frame.contentPane
      content.add(sheet_panel, BorderLayout::CENTER)
      content.add(roster_panel, BorderLayout::EAST)
      @frame.visible = true
    end

    def create_frame
      f = javax.swing.JFrame.new("Chronicle")
      f.setSize(1024, 768) # FIXME
      #f.setLocationRelativeTo(nil) centers the window FIXME
      f.defaultCloseOperation = javax.swing.JFrame::EXIT_ON_CLOSE
      return f
    end

    def sheet_panel
      s = Box.createVerticalBox
      s.add(header("Chronicle Sheet: ") { |h|
        h.add(JComboBox.new(["first steps 1", "first steps 2", "first steps 3"].to_java)) # FIXME
      })
      # FIXME May need this in a scroll pane
      s.add(PreviewPanel.new(@generator, @generator.roster.first))
      return s
    end

    def roster_panel
      r = Box.createVerticalBox
      r.add(header("Roster: "))
      r.add(roster_list)
      return r
    end

    def roster_list
      new_panel do |p|
        p.layout = GridLayout.new(8,1)
        @generator.roster.each do |i| 
          p.add(JLabel.new(i[:character_name])) # FIXME Use JTable?
        end
      end
    end

    def new_panel(w=nil, h=nil)
      p = JPanel.new
      p.maximumSize = Dimension.new(w || 10000, h || 10000)
      yield p if block_given?
      return p
    end

    def header(label)
      new_panel(nil, 120) { |p| 
        p.layout = FlowLayout.new(FlowLayout::LEADING)
        p.add(JLabel.new(label))
        yield p if block_given?
      }
    end
  end
end
