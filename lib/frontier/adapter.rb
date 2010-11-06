
module Frontier

  class Adapter

    def self.wrap(object)
      case object
      when NilClass, TrueClass, FalseClass, Symbol, Numeric, String, Exception
        return object
      when Array
        return object.map { |o| wrap(o) }
      when Hash
        return object.merge(object) { |k, v| wrap(v) }
      else
        return Proxy.new(object)
      end
    end

    def self.process(object, rx, tx)
      req = Marshal.load(rx)
      object = ObjectSpace._id2ref(req[:object]) if req.key?(:object)
      reply = object.send(req[:name], *req[:args])
      Marshal.dump(Adapter.wrap(reply), tx)
    rescue Exception => e
      Marshal.dump(e, tx)
    ensure
      tx.flush
      return reply
    end


    def initialize(rx, tx, cache = {})
      while true do
        reply = Adapter.process(self, rx, tx)
        cache[reply.object_id] = reply if reply
      end
    end

    def load(*mixins)
      [*mixins].each do |mixin|
        self.class.class_eval("include Frontier::Mixin::#{mixin.capitalize}")
      end
    end

    def method_missing(name, *args)
      %x[#{name} #{args.join(' ')}]
    end

  end

end
