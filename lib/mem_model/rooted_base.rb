module MemModel
  PERSISTENT_ROOT = {} if !MemModel.maglev?

  module RootedBase
    extend MemModel::Concern
    include Base

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

      def abort
        Maglev.abort_transaction if maglev?
        true
      end

      def commit
        Maglev.commit_transaction if maglev?
        true
      end

      def persistent(&block)
        abort
        maglev? ?
          Maglev.persistent { block.call } :
          block.call
        commit
      end
    end

    def persistent(&block)
      self.class.persistent(&block)
    end
  end
end
