require 'java'
require 'yaml'

require 'chronicle/roster_table_model'
require 'chronicle/preview_panel'

java_import java.awt.BorderLayout
java_import java.awt.Color
java_import java.awt.Dimension
java_import java.awt.FlowLayout
java_import java.awt.GridLayout
java_import java.util.Properties
java_import javax.swing.BorderFactory
java_import javax.swing.Box
java_import javax.swing.BoxLayout
java_import javax.swing.JButton
java_import javax.swing.JComboBox
java_import javax.swing.JComponent
java_import javax.swing.JFileChooser
java_import javax.swing.JLabel
java_import javax.swing.JTable
java_import javax.swing.JPanel
java_import javax.swing.JScrollPane
java_import javax.swing.ListSelectionModel
java_import javax.swing.border.BevelBorder
java_import javax.swing.filechooser.FileFilter

module Chronicle

  class ExtFileFilter < FileFilter
    def initialize(ext, desc)
      super()
      @ext = ext
      @desc = desc
    end

    def accept(f)
      f.to_s.downcase.end_with? @ext
    end

    def getDescription
      @desc
    end
  end

  class GUI 
    def initialize(generator)
      @settings = {:sheet_dir => Dir.home}
      @generator = generator
      @frame = create_frame
      content = @frame.contentPane
      content.add(create_header, BorderLayout::NORTH)
      content.add(sheet_panel, BorderLayout::CENTER)
      content.add(roster_list, BorderLayout::SOUTH)
      @frame.visible = true
    end

    def create_header
      new_panel(nil, 120) { |header| 
        header.layout = FlowLayout.new(FlowLayout::LEADING)

        sheet_button = JButton.new("Load Chronicle Sheet")
        sheet_button.add_action_listener { |e| load_sheet }
        header.add(sheet_button)

        roster_button = JButton.new("Load Roster")
        roster_button.add_action_listener { |e| load_roster }
        header.add(roster_button)

        generate_button = JButton.new("Generate Sheets")
        generate_button.add_action_listener { |e| generate_sheets }
        header.add(generate_button)

        # FIXME Add annotation tool
      }
    end

    def create_frame
      f = javax.swing.JFrame.new("Chronicle")
      f.setSize(692, 1024) 
      #f.setLocationRelativeTo(nil) centers the window FIXME
      f.defaultCloseOperation = javax.swing.JFrame::EXIT_ON_CLOSE
      return f
    end

    def sheet_panel
      s = Box.createVerticalBox
      @preview_panel = PreviewPanel.new(@generator)
      # FIXME This scroll pane doesn't want to scroll
      s.add(JScrollPane.new(@preview_panel, 
                            JScrollPane::VERTICAL_SCROLLBAR_AS_NEEDED, 
                            JScrollPane::HORIZONTAL_SCROLLBAR_NEVER))
      return s
    end

    def load_sheet
      choose_file(:sheet_dir, "png",  "Chronicle Sheet PNG files (300dpi)") do |file|
        @generator.load_sheet(file)
        @preview_panel.repaint()
      end
    end

    def generate_sheets
      choose_file(:output_dir) do |output_dir|
        @generator.write_sheets_to(output_dir)
      end
    end

    def load_roster
      choose_file(:sheet_dir, ".csv", "Roster CSV file") do |file|
        @generator.load_roster(file)
        @frame.validate
      end
    end

    def roster_list
      table = JTable.new(RosterTableModel.new(@generator))
      table.getSelectionModel.setSelectionMode ListSelectionModel::SINGLE_SELECTION
      table.getSelectionModel.add_list_selection_listener { |e|
        unless e.value_is_adjusting
          selected_row = e.source.lead_selection_index
          @preview_panel.info = @generator.roster[selected_row]
        end
      }
      p = JPanel.new
      p.setLayout(BorderLayout.new)
      p.add(table.getTableHeader, BorderLayout::NORTH)
      p.add(table, BorderLayout::CENTER)
      return p
    end

    def new_panel(w=nil, h=nil)
      p = JPanel.new
      p.maximumSize = Dimension.new(w || 10000, h || 10000)
      yield p if block_given?
      return p
    end

    def choose_file(setting, ext=nil, description=nil)
      c = JFileChooser.new
      c.setCurrentDirectory(java.io.File.new(@settings[setting]))

      if ext
        c.setFileFilter(ExtFileFilter.new(ext, description))
      else
        c.file_selection_mode = JFileChooser::DIRECTORIES_ONLY
      end

      if c.showOpenDialog(@frame) == JFileChooser::APPROVE_OPTION
        @settings[setting] = c.getCurrentDirectory.getAbsolutePath
        yield c.getSelectedFile.getAbsolutePath
        @preview_panel.repaint()
      end
    end

  end
end
