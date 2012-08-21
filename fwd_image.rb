require File.expand_path("../fwd_grid", __FILE__)

class FwdImage
  include FwdGrid

  attr_accessor :grid

  def initialize(rows = 0, cols = 0, colour = DEFAULT_VALUE)
    @grid = create(rows, cols, colour)
  end

end
