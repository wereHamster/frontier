
module Frontier

  class Channel

    def initialize(host, port)
      @remote = "#{host}:#{port}"
      @channel = IO.popen("ssh -p #{port} #{host} frontier", "r+")
    end

    def submit(request)
      Marshal.dump(request, @channel)
      return hydrate(Marshal.load(@channel))
    end

    def inspect
      "#<Frontier::Channel #{@remote}>"
    end

  private

    def hydrate(object)
      case object
      when Array, Hash
        object.each { |o| hydrate(o) }
      when Proxy
        object.channel = self
      end

      return object
    end
  end

end
