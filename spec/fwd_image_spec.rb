require "spec_helper.rb"

describe FwdImage do
  subject { FwdImage }
  it { should include_module(FwdGrid) }
end

describe "an instance of FwdImage" do

  before :each do
    @fwd_image = FwdImage.new
  end

  it { @fwd_image.should be_an_instance_of(FwdImage) }

  it "should assign an empty @grid" do
    @fwd_image.instance_variable_get(:@grid).should eq([])
  end

  it "should initialize a @grid" do
    expected = []
    expected << ["O","O"]
    expected << ["O","O"]

    @fwd_image = FwdImage.new(rows = 2, cols = 2)
    @fwd_image.instance_variable_get(:@grid).should eq(expected)
  end

end
