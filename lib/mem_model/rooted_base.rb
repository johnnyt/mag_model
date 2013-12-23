module MemModel
  module RootedBase
    def self.included(base)
      base.send :include, Base
      base.send :include, RootedStore
    end
  end
end
