class BasicCSV
  # I _should_ be able to use the built in Ruby csv to parse this,
  # but it doesn't work for me :-(
  def self.parse_lines(lines)
    header = nil
    parsed_lines = []
    parsed_line = ""
    lines.each do |line|
      if header
        parsed_line += line
        if parsed_line.count('"') % 2 == 0
          parsed_lines << parsed_line.split(',').map do |cell|
            cell.delete '"'
          end
          parsed_line = ""
        end
      else
        header = line
      end
    end
    return parsed_lines
  end
end
