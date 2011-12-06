require 'chronicle/basic_csv.rb'

describe BasicCSV do
  let (:lines) do 
    [
      "one,two,three",
      "uno,,tres",
      "1,2,3",
      'I,"I',
      'I",III'
    ]
  end

  it "joins lines when properly quoted" do
    BasicCSV.new(lines).to_a.should == [
      {:one => "uno", :two => "", :three => "tres"},
      {:one => "1", :two => "2", :three => "3"},
      {:one => 'I', :two => 'II', :three => 'III'}
    ]
  end
end
