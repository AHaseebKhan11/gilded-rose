require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'
require File.join(File.dirname(__FILE__), 'texttest_fixture')

class TestUntitled < Test::Unit::TestCase
  attr_accessor :fixtures

  def setup
    @fixtures = TextTestFixture.new
  end

  def general_item_values
    item = fixtures.gilded_rose.items[0]
    fixtures.gilded_rose.update_quality
    assert_equal 19, item.quality
    assert_equal 9, item.sell_in
  end

  def test_sulfuras_doesnt_age
    item = Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=1, quality=80)
    g = GildedRose.new([item]).update_quality
    assert_equal 80, item.quality
    assert_equal 1, item.sell_in
  end

  def legend_item_value_check
    assert_raise { GildedRose.new([Item.new(name="Sulfuras, Hand of Ragnaros",
                                            sell_in=0, quality=1000)]) }
  end

  def raise_error_quality_negative
    assert_raise { GildedRose.new([Item.new(name="Abc", sell_in=0, quality=-1)]) }
  end

  def test_update_quality_conjured
    item = Item.new(name="Conjured Mana Cake", sell_in=10, quality=50)
    g = GildedRose.new([item])
    g.update_quality
    assert_equal item.quality, 48
    assert_equal item.sell_in, 9
  end

end