module MemModel
  PERSISTENT_ROOT = {} if !MemModel.maglev?

  module Base
    extend MemModel::Concern

    included do
      include MemModel::Validations
      include MemModel::Guid
      attr_accessor :id
      alias :guid :id
      alias :guid= :id=
    end

    module ClassMethods
      include Enumerable

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


      def each(&block)
        store.each(&block)
      end

      def model_name
        @model_name ||= ModelName.new(self.name)
      end

      def store_class
        maglev? ? IdentitySet : Set
      end

      def size
        store.size
      end

      def all
        store.to_a
      end

      def last
        all[-1]
      end

      # Find or nil
      def find(id)
        store.detect{ |r| r.id == id }
      end
      alias_method :[], :find

      # Find or raise
      def find_by_id(id)
        find(id) || raise(UnknownRecord, "Couldn't find #{self.name} with ID=#{id}")
      end

      def exists?(id)
        store.any?{ |record| record.id == id }
      end

      def delete_all
        store.clear
      end

      # Create a new record.
      # Example:
      #   create(:name => "foo", :id => 1)
      def create(atts = {})
        rec = self.new(atts)
        rec.save && rec
      end

      def maglev?
        MemModel.maglev?
      end

      def abort
        MemModel.abort
      end

      def commit
        MemModel.commit
      end

      alias_method :to_str, :to_s

      def delete(record)
        persistent{ store.delete(record) }
      end

      if !MemModel.maglev?
        def committed?; false; end
      end

      def persistent(&block)
        result = committed? ?
          MemModel.persistent(&block) :
          block.call
        commit
        result
      end
    end

    def initialize(attributes = {})
      @persisted = false unless maglev?
      @id = self.class.generate_id
      load_attributes(attributes)
    end

    def model_name; self.class.model_name; end

    if !MemModel.maglev?
      def committed?; @persisted == true; end
    end

    def class_committed?
      self.class.committed?
    end

    def persisted?
      class_committed? ?
        committed? :
        @persisted == true
    end
    alias_method :exists?, :persisted?

    def new?
      !persisted?
    end
    alias_method :new_record?, :new?

    def to_key; end
    def to_param; end
    def to_partial_path; 'something'; end

    def errors; @errors ||= Errors.new(self); end

    def maglev?
      self.class.maglev?
    end

    def abort
      self.class.abort
    end

    def commit
      self.class.commit
    end

    def persistent(&block)
      self.class.persistent(&block)
    end

    def save
      new? ? create : update
    end

    def create
      persistent do
        self.class.store << self
        @persisted = true if !class_committed?
      end
      self.id
    end

    def update
      commit
      true
    end

    def update_attributes(attributes)
      load_attributes(attributes)
      save
    end

    def delete
      self.class.delete(self)
      self
    end

    def to_model
      return self
    end

    private

      def load_attributes(attributes)
        return unless attributes
        attributes.each do |(name, value)|
          self.send("#{name}=".to_sym, value)
        end
      end
  end
end
