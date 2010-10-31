
module Frontier

  class Channel

    def self.hydrate(channel, object)
      case object
      when Array, Hash
        object.each { |o| Channel.hydrate(channel, o) }
      when Proxy
        object.channel = channel
      end

      return object
    end


    def initialize(host, port)
      @channel = IO.popen("ssh #{host} frontier", "r+")
    end

    def submit(request)
      Marshal.dump(request, @channel)
      return Channel.hydrate(self, Marshal.load(@channel))
    end

  end

end
