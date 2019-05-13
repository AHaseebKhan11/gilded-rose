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