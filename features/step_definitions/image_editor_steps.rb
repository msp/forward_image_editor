Given /^I created an image$/ do
  @image = FwdImage.new(5, 5)
end

Given /^I created a coloured image$/ do
  @image = FwdImage.new(5, 5, "B")
end

When /^I create a new image with (\d+) rows & (\d+) cols$/ do |rows, cols|
  @image = FwdImage.new(rows.to_i, cols.to_i)
end

When /^I colour the pixel (\d+),(\d+) with colour "([^"]*)"$/ do |col, row, colour|
  @image.fill_value_at(row.to_i, col.to_i, colour)
end

When /^I colour a vertical range in column (\d+), from (\d+) until (\d+) with colour "([^"]*)"$/ do |col, row1, row2, colour|
  @image.fill_vertical_range(col.to_i, row1.to_i, row2.to_i, colour)
end

When /^I colour a horizontal range in row (\d+), from (\d+) until (\d+) with colour "([^"]*)"$/ do |row, col1, col2, colour|
  @image.fill_horizontal_range(row.to_i, col1.to_i, col2.to_i, colour)
end

When /^I clear the image$/ do
  @image.clear!
end

Then /^I should see the following image:$/ do |table|
  data = table.raw
  data.each_with_index do |row, i|
    row.should eq(@image.grid[i])
  end
end
