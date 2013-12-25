module MemModel
  PERSISTENT_ROOT = {} if !MemModel.maglev?

  module RootedBase
    def self.included(base)
      base.send :include, Base
      base.send :extend, ClassMethods
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

      def abort
        Maglev.abort_transaction if maglev?
        true
      end

      def commit
        Maglev.commit_transaction if maglev?
        true
      end

      def clobber!
        persistent do
          root[:MemModel].delete(container_key)
          begin
            Object.remove_const name.to_sym
          rescue NameError
          end
        end
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
