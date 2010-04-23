require 'spec_helper'
require '8ball'

describe EightBallCompiler do
  before do
    @e = EightBallCompiler
  end
  it "should compile ruby to js" do
    cs("1").should == "(1)"
    cs("'foo'").should == "('foo')"
    cs("1 + 2").should == "((1).primplus((2)))" # eventually this should be "1 + 2"
  end
end
