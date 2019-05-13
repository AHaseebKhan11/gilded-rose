require_relative './main_item.rb'

class GildedRose
  attr_reader :items, :item_collection

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
