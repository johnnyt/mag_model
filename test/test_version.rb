require 'helper'

class TestVersion < Minitest::Test
  def test_version
    assert MagModel::VERSION
  end
end
