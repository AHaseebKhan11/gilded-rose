class GildedRose
  attr_accessor :items, :item_collection

  def initialize(items)
    @items = items
    @item_collection = []
    init_items
  end

  def init_items
    items.each { |item| item_collection.push(MainItem.build_items(item)) }
  end

  def update_quality
    item_collection.each {|instance| instance.update }
  end
end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end


class MainItem
  attr_accessor :item
  Aged_Brie = 'Aged Brie'
  Back_Stage = 'Backstage passes to a TAFKAL80ETC concert'
  Con = 'Conjured Mana Cake'
  Sulfuras = 'Sulfuras, Hand of Ragnaros'

  def initialize(item)
    @item = item
    raise 'Quality value too high' if item.quality > 50 && item.name != Sulfuras
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
    case i.name
    when Con
      Conjured.new(i)
    when Sulfuras
      Sulf.new(i)
    when Aged_Brie
      AgedBrie.new(i)
    when Back_Stage
      BackStage.new(i)
    else
      MainItem.new(i)
    end
  end
end

class Conjured < MainItem
  def update
    item.quality -= 2
    item.quality -= 2 if item.sell_in <=0
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end
end

class AgedBrie < MainItem
  def update
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end
end

class BackStage < MainItem
  def update
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
      item.quality += 2
    else
      item.quality += 1
    end
    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end
end

class Sulf < MainItem
  def initialize(item)
    raise 'Give a positive quality value of 80 for legendary items' if item.quality != 80
    super item
  end

  def update; end
end