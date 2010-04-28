require 'spec_helper'
require '8ball'

describe EightBallCompiler do
  before do
    @e = EightBallVisitor.new
  end
  it "should compile ruby to js" do
    cs("1").should == "(1)"
    cs("'foo'").should == "('foo')"
    cs("1 + 2").should == "((1).primplus((2)))" # eventually this should be "1 + 2"
  end

  it "should desymbolify symbols correctly" do
    @e.desymbolify('foo!').should == "foobang"
    @e.desymbolify('foo?').should == "fooquestion"
    @e.desymbolify('').should == ""
  end
end
