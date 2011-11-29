require 'chronicle/basic_csv.rb'

describe BasicCSV do
  let (:lines) do 
    [
      "one,two,three",
      "1,2,3",
      'I,"I',
      'I",III'
    ]
  end

  it "joins lines when properly quoted" do
    BasicCSV.parse_lines(lines).should == [
      ["1","2","3"],
      ['I','II','III']
    ]
  end
end
