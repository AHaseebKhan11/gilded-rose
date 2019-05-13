class MainItem
  Dir[File.dirname(__FILE__) + '/item_classes/*.rb'].each {|file| require file }
  attr_reader :item
  SULFURUS = 'Sulfuras, Hand of Ragnaros'
  ITEM_HASH = {
                'Aged Brie' => AgedBrie,
                'Sulfuras, Hand of Ragnaros' => Sulf,
                'Backstage passes to a TAFKAL80ETC concert' => BackStage,
                'Conjured Mana Cake' => Conjured
              }.freeze

  def initialize(item)
    @item = item
    raise 'Quality value too high' if item.quality > 50 && item.name != SULFURUS
    raise 'Incorrect quality value supplied' if item.quality < 0
  end

  def update
    if item.quality > 0
      item.quality -= 1
      item.quality -= 1 if item.sell_in < 1
    end
    item.sell_in -= 1
  end

  def self.build_items(i)
    ITEM_HASH[i.name].nil? ? MainItem.new(i) : ITEM_HASH[i.name].new(i)
  end
end
