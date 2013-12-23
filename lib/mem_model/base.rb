module MemModel
  class UnknownRecord < ArgumentError; end
  class InvalidRecord < StandardError; end

  module Base
    def self.included(base)
      base.send :include, ActiveAttr::BasicModel
      base.send :extend, Enumerable
      base.send :extend, ClassMethods
      base.send :attr_accessor, :id
    end

    module ClassMethods
      def store
        @store ||= Set.new
      end

      def each
        store.each
      end

      def size
        store.size
      end

      def all
        store.to_a
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

      def update(id, atts)
        find(id).update_attributes(atts)
      end

      def destroy(id)
        find(id).destroy
      end

      # Removes all records and executes
      # destroy callbacks.
      def destroy_all
        all.each {|r| r.destroy }
      end

      # Removes all records without executing
      # destroy callbacks.
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

      def create!(*args)
        create(*args) || raise(InvalidRecord)
      end
    end

    def initialize(attributes = {})
      @persisted = false
      self.id = self.class.generate_id
      load_attributes(attributes)
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

    def save!
      save || raise(InvalidRecord)
    end

    def create
      self.id ||= generate_id
      self.class.store << self
      @persisted = true
      self.id
    end

    def update
      # no-op
      true
    end

    def update_attributes(attributes)
      load_attributes(attributes)
      save
    end

    def destroy
      self.class.records.delete(self.id)
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
