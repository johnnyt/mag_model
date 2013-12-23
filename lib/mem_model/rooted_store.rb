module MemModel
  PERSISTENT_ROOT = {} if !MemModel.maglev?

  module RootedStore
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def store_class
        MemModel.maglev? ? IdentitySet : Set
      end

      def root_container
        MemModel.maglev? ? Maglev : MemModel
      end

      def store
        root[:MemModel] ||= {}
        root[:MemModel][name] ||= store_class.new
      end

      def root
        @root ||= root_container::PERSISTENT_ROOT
      end
    end
  end
end
