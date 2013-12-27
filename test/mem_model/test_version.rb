require File.expand_path('../../helper', __FILE__)

class TestVersion < Minitest::Test
  def test_version
    assert MemModel::VERSION
  end
end
