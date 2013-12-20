require 'helper'

class TestVersion < Minitest::Test
  def test_version
    assert MemModel::VERSION
  end
end
