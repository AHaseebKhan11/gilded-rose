class Sulf < MainItem
  def initialize(item)
    raise 'Give a positive quality value of 80 for legendary items' if item.quality != 80
    super item
  end

  def update; end
end