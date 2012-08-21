module FwdGrid
  DEFAULT_VALUE = "O"

  def create(rows, cols, value = DEFAULT_VALUE)
    @grid = Array.new(rows) { Array.new(cols) { value } }
    @grid
  end

  def clear!
    @grid = Array.new(@grid.length) { Array.new(@grid[0].length) { DEFAULT_VALUE } }
    pp @grid
    @grid
  end

  def fill_value_at(row, col, value)
    validate_row(row)
    validate_column(col)

    @grid[row-1][col-1] = value
    pp @grid
    @grid
  end

  def fill_vertical_range(col, row1, row2, value)
    validate_column(col)
    validate_row(row1)
    validate_row(row2)
    @grid.each_with_index do |row, i|
      row[col-1] = value if i >= row1-1 && i <= row2-1
    end
    pp @grid
    @grid
  end

  def fill_horizontal_range(row, col1, col2, value)
    validate_row(row)
    validate_column(col1)
    validate_column(col2)
    @grid[row-1].fill(value, (col1-1)..(col2-1))
    pp @grid
    @grid
  end

  private
  def validate_row(row)
    raise if row < 1 || row > @grid.length
  end

  def validate_column(col)
    raise if col < 1 || col > @grid[0].length
  end

end
