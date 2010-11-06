
module Frontier

  module Utils

    def self.xfer(dst, src)
      if src.file?
        dst = dst + src.basename.to_s if dst.directory?
        copy(dst, src)
      elsif src.directory?
        src.children.each do |child|
          xfer(dst + src.basename.to_s, child)
        end
      end
    end

  private

    def self.copy(dst, src)
      dst.dirname.mkpath
      dst, src = dst.open("w+"), src.open("r")
      while chunk = src.read(4096)
        dst.write(chunk)
      end
    end

  end

end
