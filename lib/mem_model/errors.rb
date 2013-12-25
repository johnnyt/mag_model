module MemModel
  class UnknownRecord < ArgumentError; end
  class InvalidRecord < StandardError; end

  class Errors
    include Enumerable

    attr_reader :messages

    def initialize(base)
      @base     = base
      @messages = {}
    end

    def each
      messages.each_key do |attribute|
        self[attribute].each { |error| yield attribute, error }
      end
    end

    def full_messages
      map { |attribute, message| full_message(attribute, message) }
    end

    def full_message(attribute, message)
      [attribute, message].join(' ')
    end

    def [](attribute)
      get(attribute.to_sym) || set(attribute.to_sym, [])
    end

    def []=(attribute, error)
      self[attribute] << error
    end

    def get(key)
      messages[key]
    end

    def set(key, value)
      messages[key] = value
    end
  end
end
