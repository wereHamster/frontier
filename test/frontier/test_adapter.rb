require 'helper'

class AdapterTest < Test::Unit::TestCase

  context "#wrap" do

    should "preserve Nil, Boolean, Symbol, Numeric, String, Exception, Array and Hash class" do
      [ nil, true, false, :sym, Numeric.new, String.new, Exception.new, Array.new, Hash.new ].each do |obj|
        assert_instance_of(obj.class, Frontier::Adapter.wrap(obj))
      end
    end

    should "wrap custom classes in a proxy" do
      class CustomClass; end
      obj = Frontier::Adapter.wrap(CustomClass.new)
      assert_instance_of(Frontier::Proxy, obj)
    end

  end

end
