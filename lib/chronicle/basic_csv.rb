class BasicCSV
  include Enumerable

  def initialize(lines)
    @header = create_header(lines.shift)
    @lines = lines
  end

  def create_header(line)
    line.split(',').map { |cell| cell.to_sym }
  end

  def create_row(line)
    line.split(',').inject(Hash.new) do |row, cell| 
      cell_data = cell.delete '"' 
      column_number = row.size
      row[@header[column_number]] = cell_data
      row
    end
  end

  # I _should_ be able to use the built in Ruby csv to parse this,
  # but it doesn't work for me :-(
  def each
    rows = []
    parsed_line = ""
    @lines.each do |line|
      parsed_line += line
      if parsed_line.count('"') % 2 == 0
        rows << create_row(parsed_line)
        parsed_line = ""
      end
    end
    return rows
  end
end
