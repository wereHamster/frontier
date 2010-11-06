require 'helper'

class FilesystemTest < Test::Unit::TestCase

    context "#[]" do

      setup do
        @adapter = Object.new
        @adapter.class.class_eval("include Frontier::Mixin::Filesystem")
      end

      should "return a Pathname object when string contains no asterisk" do
        assert_instance_of(Pathname, @adapter['file'])
      end

      should "return an array when string contains an asterisk" do
        assert_instance_of(Array, @adapter['*'])
      end

    end

end
