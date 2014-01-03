module MemModel
  PERSISTENT_ROOT = {} if !MemModel.maglev?

  module RootedBase
    extend MemModel::Concern

    included do
      include MemModel::Base
    end

    module ClassMethods
      def root_container
        MemModel.maglev? ? Maglev : MemModel
      end

      def container_key
        name.to_sym
      end

      def store
        root[:MemModel] ||= {}
        root[:MemModel][container_key] ||= store_class.new
      end

      def root
        @root ||= root_container::PERSISTENT_ROOT
      end
    end
  end
end
