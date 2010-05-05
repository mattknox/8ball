require 'spec_helper'
require '8ball'

describe EightBallCompiler do
  before do
    @e = EightBallVisitor.new
  end
  it "should compile ruby to js" do
    cs("1").should == "(1)"
    cs("'foo'").should == "('foo')"
    cs("1 + 2").should == "((1).rubyplus((2)))" # eventually this should be "1 + 2"
    cs("true").should == "true"
    cs("false").should == "false"
    cs("true ? 1 : 2").should == "(true) ? (1) : (2)"
    cs("").should == ""
  end

  it "should desymbolify symbols correctly" do
    @e.desymbolify('foo!').should == "foobang"
    @e.desymbolify('foo?').should == "fooquestion"
    @e.desymbolify('foo').should == "foo"
    @e.desymbolify('foo_bar').should == "foo_bar"
    @e.desymbolify('fooBar').should == "fooBar"
    @e.desymbolify('').should == ""
  end
end
