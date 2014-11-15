require 'minitest_helper'

class TestHexapic < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Hexapic::VERSION
  end
end
