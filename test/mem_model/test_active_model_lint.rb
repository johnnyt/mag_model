require File.expand_path('../../helper', __FILE__)

class TestActiveModelLint < Minitest::Test
  include ActiveModel::Lint::Tests

  class CompliantModel
    include MemModel::Base
  end

  def setup
    @model = CompliantModel.new
  end
end
