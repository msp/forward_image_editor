require "spec_helper.rb"

describe FwdGrid do

  class DummyImageClass
    def initialize
      @grid = []
    end
  end

  before :all do
    @fwd_grid = DummyImageClass.new
    @fwd_grid.extend FwdGrid
  end

  describe "'s interface" do

    before :each do
      @rows = 5
      @cols = 3
      @value = "C"
    end

    describe "create:" do

      it "should allow creation of a new grid of arbitrary size" do
        @fwd_grid.create(@rows, @cols, @value).should eq(Array.new(@rows){Array.new(@cols) {@value}})
      end

      it "should assign the grid to @grid in the including class" do
        @fwd_grid.create(@rows, @cols, @value)
        @fwd_grid.instance_variable_get(:@grid).should eq(Array.new(@rows){Array.new(@cols) {@value}})
      end

      it "should allow empty rows" do
        @fwd_grid.create(0, @cols, @value).should eq(Array.new(0){Array.new(@cols) {@value}})
      end

      it "should allow empty cols" do
        @fwd_grid.create(@rows, 0, @value).should eq(Array.new(@rows){Array.new(0) {@value}})
      end

      it "default the grid value to 'O'" do
        @fwd_grid.create(@rows, @cols).should eq(Array.new(@rows){Array.new(@cols) {"O"}})
      end
    end


    describe "clear!:" do

      it "with empty rows" do
        @fwd_grid.create(0, @cols, @value)
        @fwd_grid.clear!.should eq([])
      end

      it "with empty cols" do
        @fwd_grid.create(@rows, 0, @value)
        @fwd_grid.clear!.should eq([[],[],[],[],[]])
      end

      it "should set all the pixels to default color" do

        coloured_array = Array.new(@rows){Array.new(@cols) {@value}}
        white_array = Array.new(@rows){Array.new(@cols) {"O"}}

        @fwd_grid.create(@rows, @cols, @value)

        @fwd_grid.instance_variable_get(:@grid).should eq(coloured_array)
        @fwd_grid.instance_variable_get(:@grid).should_not eq(white_array)

        @fwd_grid.clear!.should eq(white_array)
      end
    end

    describe "fill_value_at" do
      before :each do
        @fwd_grid.create(@rows, @cols)
        @new_value = "Z"
      end

      it "should return error if col out of range" do
        lambda {@fwd_grid.fill_value_at(@rows - 2, @cols + 2, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row out of range" do
        lambda {@fwd_grid.fill_value_at(@rows + 2, @cols - 2, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row less than one" do
        lambda {@fwd_grid.fill_value_at(0, @cols, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col less than one" do
        lambda {@fwd_grid.fill_value_at(@rows, 0, @new_value)}.should raise_error(RuntimeError)
      end

      it "should fill the value at 2,2 (1 based index)" do
        expected = []
        expected << ["O","O","O"]
        expected << ["O","Z","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        @fwd_grid.fill_value_at(2, 2, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

      it "should fill the value at 5,3 (1 based index)" do
        expected = []
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","Z"]
        @fwd_grid.fill_value_at(5, 3, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end
    end

    describe "fill_vertical_range" do

      before :each do
        @fwd_grid.create(@rows, @cols)
        @new_value = "X"
      end

      it "should return error if col out of range" do
        lambda {@fwd_grid.fill_vertical_range(col = 99, row1 = 1, row2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col less than one" do
        lambda {@fwd_grid.fill_vertical_range(col = 0, row1 = 1, row2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row1 out of range" do
        lambda {@fwd_grid.fill_vertical_range(col = 1, row1 = 99, row2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row1 less than one" do
        lambda {@fwd_grid.fill_vertical_range(col = 0, row1 = 0, row2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row2 out of range" do
        lambda {@fwd_grid.fill_vertical_range(col = 1, row1 = 0, row2 = 99, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row2 less than one" do
        lambda {@fwd_grid.fill_vertical_range(col = 1, row1 = 1, row2 = 0, @new_value)}.should raise_error(RuntimeError)
      end

      it "should fill col 1 with value, between 2 & 3" do
        expected = []
        expected << ["O","O","O"]
        expected << ["X","O","O"]
        expected << ["X","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        @fwd_grid.fill_vertical_range(col = 1, row1 = 2, row2 = 3, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

      it "should fill col 2 with value, between 1 & 4" do
        expected = []
        expected << ["O","X","O"]
        expected << ["O","X","O"]
        expected << ["O","X","O"]
        expected << ["O","X","O"]
        expected << ["O","O","O"]
        @fwd_grid.fill_vertical_range(col = 2, row1 = 1, row2 = 4, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

      it "should fill col 3 with value, between 5 & 5" do
        expected = []
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","X"]
        @fwd_grid.fill_vertical_range(col = 3, row1 = 5, row2 = 5, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end
    end

    describe "fill_horizontal_range" do
      before :each do
        @fwd_grid.create(@rows, @cols)
        @new_value = "Y"
      end

      it "should return error if row out of range" do
        lambda {@fwd_grid.fill_horizontal_range(row = 99, col1 = 1, col2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if row less than one" do
        lambda {@fwd_grid.fill_horizontal_range(row = 0, col1 = 1, col2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col1 out of range" do
        lambda {@fwd_grid.fill_horizontal_range(row = 1, col1 = 99, col2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col1 less than one" do
        lambda {@fwd_grid.fill_horizontal_range(row = 1, col1 = 0, col2 = 1, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col2 out of range" do
        lambda {@fwd_grid.fill_horizontal_range(row = 1, col1 = 1, col2 = 99, @new_value)}.should raise_error(RuntimeError)
      end

      it "should return error if col2 less than one" do
        lambda {@fwd_grid.fill_horizontal_range(row = 1, col1 = 1, col2 = 0, @new_value)}.should raise_error(RuntimeError)
      end

      it "should fill row 1 with value, between 2 & 3" do
        expected = []
        expected << ["O","Y","Y"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        @fwd_grid.fill_horizontal_range(row = 1, col1 = 2, col2 = 3, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

      it "should fill row 3 with value, between 1 & 3" do
        expected = []
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["Y","Y","Y"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        @fwd_grid.fill_horizontal_range(row = 3, col1 = 1, col2 = 3, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

      it "should fill row 5 with value, between 1 & 1" do
        expected = []
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["O","O","O"]
        expected << ["Y","O","O"]
        @fwd_grid.fill_horizontal_range(row = 5, col1 = 1, col2 = 1, @new_value)
        @fwd_grid.instance_variable_get(:@grid).should eq(expected)
      end

    end
  end
end

