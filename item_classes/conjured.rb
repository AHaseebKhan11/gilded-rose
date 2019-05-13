class Conjured < MainItem
  def update
    item.quality -= 2
    item.quality -= 2 if item.sell_in <=0
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end
end