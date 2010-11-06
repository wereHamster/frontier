
require 'pathname'

module Frontier::Mixin::Filesystem

  def [](str)
    str.include?('*') ? Pathname.glob(str) : Pathname.new(str)
  end

end
