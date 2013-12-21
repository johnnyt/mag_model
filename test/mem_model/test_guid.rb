require File.expand_path('../../helper', __FILE__)

class TestGuid < Minitest::Test
  class Account
    include MemModel::Base
    include MemModel::Guid
  end

  def guid_regexp
    /^\w{3}-\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/
  end

  def test_new_guid_uniqueness
    assert_match guid_regexp, Account.generate_id
  end
end
