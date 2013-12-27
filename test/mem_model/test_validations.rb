require File.expand_path('../../helper', __FILE__)

class TestValidations < Minitest::Test
  class Account
    include MemModel::Base
    attr_accessor :balance
    validates_presence_of :balance
  end

  def setup
    @account = Account.new
  end

  def teardown
    @account = nil
    Account.delete_all
  end

  def test_presence
    refute @account.valid?
    @account.balance = 0
    assert @account.valid?
  end
end
