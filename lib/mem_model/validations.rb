module MemModel
  module Validations
    extend MemModel::Concern

    module ClassMethods
      def validations
        @validations ||= []
      end

      def validates_presence_of(attr)
        validations << [:presence, attr]
      end
    end

    def valid?
      validations.empty? || validations.all? do |kind, attr|
        value = self.send(attr)
        value && value != ''
      end
    end

    def validations
      self.class.validations
    end
  end
end
