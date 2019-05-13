require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe 'update_quality function' do

    describe 'Concert items' do
      it 'increases to 50 when sell_in above 10 and quality is 49' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=15, quality=49)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq 14
        expect(item.quality).to eq 50
      end

      it 'Quality stays same for back stage pass' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=15, quality=50)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq 14
        expect(item.quality).to eq 50
      end

      it 'Quality reduces to zero once concert date has passed' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=0, quality=50)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq -1
        expect(item.quality).to eq 0
      end
    end


    describe 'Regular items' do
      it 'Quality reduces twice as fast for regular items' do
        item = Item.new('Lorem ispum', sell_in=0, quality=10)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq -1
        expect(item.quality).to eq 8
      end
    end

    describe 'Exceptions' do
      it 'Raise exception when quality is negative' do
        item = Item.new('Lorem ispum', sell_in=0, quality=-10)
        items = [item]
        expect { described_class.new(items) }.to raise_exception('Incorrect quality value supplied')
      end

      it 'Raise exception when quality is too high' do
        item = Item.new('Lorem ispum', sell_in=0, quality=60)
        items = [item]
        expect { described_class.new(items) }.to raise_exception('Quality value too high')
      end

      it 'Raise exception when quality is incorrect for legendary item' do
        item = Item.new('Sulfuras, Hand of Ragnaros', sell_in=1, quality=60)
        items = [item]
        expect { described_class.new(items) }.to raise_exception('Give a positive quality value of 80 for legendary items')
      end
    end

    describe 'Conjured items delay twice as fast' do
      it 'Sell in date has not passed' do
        item = Item.new('Conjured', sell_in=2, quality=10)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq 1
        expect(item.quality).to eq 8
      end

      it 'Sell in date has passed and quality is not less than zero' do
        item = Item.new('Conjured', sell_in=-1, quality=3)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq -2
        expect(item.quality).to eq 0
      end
    end

    describe 'Sulfuras items' do
      it 'Sell in date has not passed' do
        item = Item.new('Sulfuras, Hand of Ragnaros', sell_in=2, quality=80)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        # Sell in date or qulity is not affected for Sulfurus
        expect(item.sell_in).to eq 2
        expect(item.quality).to eq 80
      end

      it 'Sell in date has passed and quality is not less than zero' do
        item = Item.new('Sulfuras, Hand of Ragnaros', sell_in=-1, quality=80)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        # Sell in date or qulity is not affected for Sulfurus
        expect(item.sell_in).to eq -1
        expect(item.quality).to eq 80
      end
    end

    describe 'Aged brie' do
      it 'Sell in date has not passed' do
        item = Item.new('Aged Brie', sell_in=2, quality=10)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq 1
        expect(item.quality).to eq 11
      end

      it 'Aged brie increases twice as fast when sell in date has passed' do
        item = Item.new('Aged Brie', sell_in=-1, quality=3)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq -2
        expect(item.quality).to eq 5
      end
    end
  end
end
