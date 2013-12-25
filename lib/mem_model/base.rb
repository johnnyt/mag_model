module MemModel
  module Base
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :include, ActiveModelInstanceMethods
      base.send :attr_accessor, :id
    end

    module ActiveModelInstanceMethods
      def model_name; self.class.model_name; end
      def valid?; true; end
      def persisted?; true; end

      def to_key; end
      def to_param; end
      def to_partial_path; 'something'; end

      def errors; @errors ||= Errors.new(self); end
    end

    module ClassMethods
      include Enumerable

      def each(&block)
        store.each(&block)
      end

      def model_name
        @model_name ||= ModelName.new(self.name)
      end

      def store_class
        MemModel.maglev? ? IdentitySet : Set
      end

      def store
        @store ||= store_class.new
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

      def generate_id
        object_id
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
        # no-op
        true
      end

      def commit
        # no-op
        true
      end

      alias_method :to_str, :to_s

      def delete(record)
        store.delete(record)
      end
    end

    def initialize(attributes = {})
      @persisted = false
      self.id = self.class.generate_id
      load_attributes(attributes)
    end

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
      # no-op
      block.call
    end

    def new?
      !exists?
    end
    alias_method :new_record?, :new?

    def exists?
      @persisted == true
    end

    def save
      new? ? create : update
    end

    def create
      self.id ||= generate_id
      persistent do
        self.class.store << self
        @persisted = true
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
