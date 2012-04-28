require 'java'

java_import javax.swing.table.AbstractTableModel

module Chronicle
  class RosterTableModel < AbstractTableModel
    def initialize(generator)
      super()
      @generator = generator
      @columns = [
        :character_name, 
        :player_name, 
        :society_number, 
        :character_number, 
        :faction
      ]
    end

    def getColumnName(col)
      @columns[col].to_s
    end

    def getColumnCount 
      @columns.length
    end

    def getRowCount
      @generator.roster.length
    end

    def getValueAt(row, col)
      @generator.roster[row][@columns[col]]
    end
  end
end
