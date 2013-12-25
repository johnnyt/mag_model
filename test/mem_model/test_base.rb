require File.expand_path('../../helper', __FILE__)

class TestBase < Minitest::Test
  class Account
    include MemModel::Base
    attr_accessor :balance
  end

  def setup
    @account = Account.new
  end

  def teardown
    @account = nil
    Account.delete_all
  end

  def test_not_exists
    refute Account.exists? 314159
  end

  def test_exists
    refute Account.exists? @account.id
    @account.save
    assert Account.exists? @account.id
  end

  #def test_update
  #  @account.save
  #  new_balance = 314
  #  refute_equal new_balance, @account.balance

  #  Account.update @account.id, :balance => new_balance
  #  assert_equal new_balance, @account.balance
  #end

  def test_new_model_is_new_record
    assert @account.new_record?
  end

  def test_saved_model_is_persisted
    @account.save
    refute @account.new_record?
  end

  def test_find_nonexistent_record
    assert_raises(MemModel::UnknownRecord) do
      Account.find_by_id 'wat'
    end
  end

  def test_find
    @account.save
    assert_equal @account, Account.find(@account.id)
  end

  def test_size
    assert Account.size.zero?
    @account.save
    assert_equal 1, Account.size
  end

  def test_last
    @account.save
    assert_equal @account, Account.last
  end

  def test_all
    @account.save
    assert_equal [@account], Account.all
  end

  def test_abort
    # no-op in MRI
    assert @account.abort
  end

  def test_commit
    # no-op in MRI
    assert @account.commit
  end

  def test_delete
    @account.save
    refute Account.size.zero?
    @account.delete
    assert Account.size.zero?
  end

  def test_maglev?
    if defined? Maglev
      assert @account.maglev?
    else
      refute @account.maglev?
    end
  end
end
