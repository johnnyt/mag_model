module MemModel
  class UnknownRecord < ArgumentError; end
  class InvalidRecord < StandardError; end

  module Base
    def self.included(base)
      base.send :include, ActiveAttr::Model
      base.send :extend, Enumerable
      base.send :extend, ClassMethods
      base.class_eval do
        attribute :id
      end
    end

    module ClassMethods
      extend Forwardable
      def_delegators :store, :each, :size, :entries
      alias_method :all, :entries

      def store
        @store ||= Set.new
      end

      def generate_id
        [guid_prefix, '-', SecureRandom.uuid].join.upcase
      end

      def guid_prefix
        self.name[0...3]
      end

      def store
        @store ||= Set.new
      end

      def find_by_id(id)
        store.detect{ |r| id == r.id } || raise(UnknownRecord, "Couldn't find #{self.name} with ID=#{id}")
      end

      def find_all_by_id(substring)
        records = store.select{ |r| r.id.include?(substring.to_s.upcase) }
        records && records.size == 1 ?
          records.first :
          records || raise(UnknownRecord, "Couldn't find #{self.name} with ID=#{id}")
      end

      def [](substring)
        store.detect{ |r| r.id.include?(substring.to_s.upcase) } || raise(UnknownRecord, "Couldn't find #{self.name} with ID=~#{substring}")
      end

      def find(id)
        store.detect{ |r| r.id == id } || raise(UnknownRecord, "Couldn't find #{self.name} with ID=#{id}")
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
      load(attributes)
    end

    def load(attributes) #:nodoc:
      return unless attributes
      attributes.each do |(name, value)|
        self.send("#{name}=".to_sym, value)
      end
    end

    def to_model
      return self
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

    def destroy
      self.class.records.delete(self.id)
      self
    end

    def create
      self.id ||= generate_id
      @persisted = true
      self.class.store << self
      self.id
    end

    def update
      item = self.class.raw_find(id)
      item.load(attributes)
      true
    end
  end
end
