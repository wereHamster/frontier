
module Frontier

  class Shell

    def initialize(host = 'localhost', port = 22)
      @host = host
      @port = port
    end

    def method_missing(name, *args)
      @channel ||= Channel.new(@host, @port)
      return @channel.submit({ :name => name, :args => args })
    end

  end

end
