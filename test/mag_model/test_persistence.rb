require File.expand_path('../../helper', __FILE__)

class TestPersistence < Minitest::Test
  class Account
    include MagModel::Base
    attribute :balance
  end

  def setup
    @account = Account.new
  end

  def teardown
    @account = nil
    Account.delete_all
  end

  def test_new_model_is_new_record
    assert @account.new_record?
  end

  def test_saved_model_is_persisted
    @account.save
    refute @account.new_record?
  end

  def test_find_nonexistent_record
    assert_raises(MagModel::UnknownRecord) do
      Account.find 'wat'
    end
  end

  def test_find
    @account.save
    assert_equal @account, Account.find(@account.id)
  end
end
