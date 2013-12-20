require File.expand_path('../../helper', __FILE__)

class TestBase < Minitest::Test
  class Account
    include MemModel::Base
  end

  def test_new_guid_uniqueness
    refute_equal Account.generate_id, Account.generate_id
  end
end
