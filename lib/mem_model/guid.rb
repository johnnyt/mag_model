module MemModel
  module Guid
    extend MemModel::Concern

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
