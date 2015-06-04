module Moxie
  class UI
    def self.table(cols, objects=[])
      rows = objects.map do |obj|
        cols.map { |m| obj.send(m) }
      end

      table = Terminal::Table.new(rows: rows)
      table.headings = *cols.map(&:to_s).map(&:upcase).map(&:bold)
      table.style = { padding_left: 0, padding_right: 4, border_y: '', border_i: '' }
      return table
    end
  end
end

