require File.expand_path('../../helper', __FILE__)

class TestRootedBase < Minitest::Test
  class Account
    include MemModel::RootedBase
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

  if MemModel.maglev?

    def test_maglev_exists
      assert_raises TransactionError, 'The test Account class is transient' do
        @account.save
      end
    end

  else

    def test_mri_exists
      refute Account.exists? @account.id
      @account.save
      assert Account.exists? @account.id
    end

  end

  def test_root_container
    if defined?(Maglev)
      assert_equal Maglev, Account.root_container
    else
      assert_equal MemModel, Account.root_container
    end
  end

  def test_abort
    # no-op in MRI
    assert @account.abort
  end

  def test_commit
    # no-op in MRI
    assert @account.commit
  end
end
