
module Frontier

  class Adapter

    def self.wrap(object)
      case object
      when Numeric, String, Exception
        return object
      when Array
        return object.map { |o| wrap(o) }
      when Hash
        return object.merge(object) { |k, v| wrap(v) }
      else
        return Proxy.new(object)
      end
    end


    def initialize
      @cache = {}

      while true do
        begin
          request = Marshal.load($stdin)

          if request[:object]
            object = ObjectSpace._id2ref(request[:object])
          else
            object = self
          end

          reply = object.send(request[:name], *request[:args])
          @cache[reply.object_id] = reply
          Marshal.dump(Adapter.wrap(reply), $stdout)
        rescue Exception => e
          Marshal.dump(e, $stdout)
        end
        $stdout.flush
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
