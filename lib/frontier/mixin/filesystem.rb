
require 'pathname'

module Frontier::Mixin::Filesystem

  def [](glob)
    Pathname.glob(glob)
  end

end
