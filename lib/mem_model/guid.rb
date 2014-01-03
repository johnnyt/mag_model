module MemModel
  module Guid
    extend MemModel::Concern

    def generate_id
      self.class.generate_id
    end

    module ClassMethods
      def generate_id
        [guid_prefix, '-', new_uuid].join.upcase
      end

      def guid_prefix
        name[0...3]
      end

      def find_all_matching(substring)
        store.select{ |r| r.id.include?(substring.to_s.upcase) }
      end

      def random_bytes(n=16)
        flags = File::RDONLY
        flags |= File::NONBLOCK if defined? File::NONBLOCK
        flags |= File::NOCTTY if defined? File::NOCTTY
        flags |= File::NOFOLLOW if defined? File::NOFOLLOW
        begin
          File.open("/dev/urandom", flags) {|f|
            unless f.stat.chardev?
              raise Errno::ENOENT
            end
            ret = f.readpartial(n)
            if ret.length != n
              raise NotImplementedError, "Unexpected partial read from random device"
            end
            return ret
          }
        rescue Errno::ENOENT
          raise NotImplementedError, "No random device"
        end
      end

      def new_uuid
        ary = self.random_bytes(16).unpack("NnnnnN")
        ary[2] = (ary[2] & 0x0fff) | 0x4000
        ary[3] = (ary[3] & 0x3fff) | 0x8000
        "%08x-%04x-%04x-%04x-%04x%08x" % ary
      end
    end
  end
end
