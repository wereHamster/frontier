
module Frontier

  class Shell

    def initialize(host = 'localhost', port = 22)
      @channel = Channel.new(host, port)
    end

    def method_missing(name, *args)
      return @channel.submit({ :name => name, :args => args })
    end

  end

end
