module MemModel
  module Guid
    def self.included(base)
      base.send :extend, MemModel::Guid::ClassMethods
    end

    module ClassMethods
      def generate_id
        [guid_prefix, '-', SecureRandom.uuid].join.upcase
      end

      def guid_prefix
        name[0...3]
      end

      def find_all_matching(substring)
        store.select{ |r| r.id.include?(substring.to_s.upcase) }
      end
    end
  end
end
