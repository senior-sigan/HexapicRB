require 'minitest_helper'

class TestWallpaper < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Wallpaper::VERSION
  end
end
