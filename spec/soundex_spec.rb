# bowling_spec.rb
require 'soundex'

describe String, "#nysiis" do
  it "returns '' when run against a blank string" do
    ''.nysiis.should == ''
  end

  it "processes words individually when given a sentence" do
    'how are you?'.nysiis.should == 'H AR Y'
  end

  it "should return '' for a number" do
    '2'.nysiis.should == ''
  end
end

describe NilClass, "#nysiis" do
  it "returns ''" do
    nil.nysiis.should == ''
  end
end