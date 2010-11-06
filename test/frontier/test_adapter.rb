require 'helper'

class AdapterTest < Test::Unit::TestCase

  context "#wrap" do

    should "preserve Numeric, String, Exception, Array and Hash class" do
      [ Numeric, String, Exception, Array, Hash ].each do |klass|
        obj = Frontier::Adapter.wrap(klass.new)
        assert_instance_of(klass, obj)
      end
    end

    should "wrap custom classes in a proxy" do
      class CustomClass; end
      obj = Frontier::Adapter.wrap(CustomClass.new)
      assert_instance_of(Frontier::Proxy, obj)
    end

  end

end
