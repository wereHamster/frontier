require 'helper'

class FrontierAdapterTest < Test::Unit::TestCase

  context "wrapping objects" do

    should "preserve Array class" do
      a = [1, 2]
      b = Frontier::Adapter.wrap(a)
      assert_equal a.class, b.class
    end

    should "preserve Hash class" do
      a = { :a => 1 }
      b = Frontier::Adapter.wrap(a)
      assert_equal a.class, b.class
    end

  end

end
