require "./spec_helper"

describe "Idn" do
  describe "to_unicode" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.each do |testcase, vector|
        Idn.to_unicode(vector[1]).should eq vector[0]
      end
    end
    
    it "should respect * and not try to decode it" do
      Idn.to_unicode("*.xn--mllerriis-l8a.com").should eq("*.møllerriis.com")
    end
    
    it "should respect leading _ and not try to encode it" do
      Idn.to_unicode("_something.xn--mllerriis-l8a.com").should eq "_something.møllerriis.com"
    end  
  end
  
  describe "to_ascii" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.each do |testcase, vector|
        Idn.to_ascii(vector[0]).should eq vector[1].downcase
      end
    end
    
    it "should respect * and not try to encode it" do
      Idn.to_ascii("*.hello.com").should eq "*.hello.com"
    end
    
    it "should respect leading _ and not try to encode it" do
      Idn.to_ascii("_something.example.org").should eq "_something.example.org"
    end
  end
end
