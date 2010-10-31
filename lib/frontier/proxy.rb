
module Frontier

  class Proxy
    attr_accessor :channel

    def initialize(object)
      @typename = object.class.to_s
      @object = object.object_id
    end

    def method_missing(name, *args)
      request = { :object => @object, :name => name, :args => args }
      return @channel.submit(request)
    end

  end

end
