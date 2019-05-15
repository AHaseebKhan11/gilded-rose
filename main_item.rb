class MainItem
  Dir[File.dirname(__FILE__) + '/item_classes/*.rb'].each {|file| require file }
  attr_reader :item
  ITEM_HASH = {
                'Aged Brie' => AgedBrie,
                'Sulfuras, Hand of Ragnaros' => Sulf,
                'Backstage passes to a TAFKAL80ETC concert' => BackStage,
                'Conjured Mana Cake' => Conjured
              }.freeze

  def initialize(item)
    @item = item
    raise_exceptions
  end

  def update
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 1
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end

  def self.build_items(i)
    ITEM_HASH[i.name].nil? ? MainItem.new(i) : ITEM_HASH[i.name].new(i)
  end

  private
  def raise_exceptions
    raise 'Quality value too high' if item.quality > 50 && ITEM_HASH[item.name] != Sulf
    raise 'Incorrect quality value supplied' if item.quality < 0
  end
end
