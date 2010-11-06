
module Frontier

  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__.*__$)/ }
    attr_accessor :channel

    def initialize(object)
      @object = object.object_id
    end

    def method_missing(name, *args)
      request = { :object => @object, :name => name, :args => args }
      return @channel.submit(request)
    end

    def inspect
      "#<Frontier::Proxy #{method_missing(:inspect)}>"
    end

  end

end
