require 'chronicle/ext_file_filter'

describe Chronicle::ExtFileFilter do
  it "only accepts files with the selected extension" do
    filter = Chronicle::ExtFileFilter.new("gif", "Hi!")
    filter.accept("foo.GIF").should be true
    filter.accept("foo.jpg").should be false
  end
end
