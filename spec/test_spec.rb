require './enumerable'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:range) { (1..6) }
  let(:hash) { { foo: 0, bar: 1, baz: 2 } }
  let(:test_proc) { proc { |x| x * 2 } }
  let(:sort_proc) { proc { |memo, word| memo.length > word.length ? memo : word } }

  describe '#my_each' do
    it 'iterates an array yeilds each element' do
      my_each_array = []
      each_array = []
      arr.my_each { |x| my_each_array << (x * 2) }
      arr.each { |x| each_array << (x * 2) }
      expect(my_each_array).to eql(each_array)
    end

    it 'iterates a range yields each element' do
      my_each_array = []
      each_array = []
      range.my_each { |x| my_each_array << (x * 2) }
      range.each { |x| each_array << (x * 2) }
      expect(my_each_array).to eql(each_array)
    end

    it 'iterates a hash yeilds each element pair' do
      my_each_array = []
      each_array = []
      hash.my_each { |key, value| my_each_array << "#{key} : #{value}" }
      hash.each { |key, value| each_array << "#{key} : #{value}" }
      expect(my_each_array).to eql(each_array)
    end

    it 'returns the original object passsed to it ' do
      expect(arr.my_each { |x| }).to eql(arr)
    end
    it 'returns the enumerable object when  no block is passed' do
      expect(arr.my_each).to be_an_instance_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates an array and yield item and index of item' do
      my_each_hash = {}
      each_hash = {}
      arr.my_each_with_index { |item, index| my_each_hash[item] = index }
      arr.each_with_index { |item, index| each_hash[item] = index }
      expect(my_each_hash).to eql(each_hash)
    end
    it 'iterates a range and yield item and index of item' do
      my_each_hash = {}
      each_hash = {}
      range.my_each_with_index { |item, index| my_each_hash[item] = index }
      range.each_with_index { |item, index| each_hash[item] = index }
      expect(my_each_hash).to eql(each_hash)
    end
    it 'iterates a hash and yield item and index of item' do
      my_each_hash = {}
      each_hash = {}
      hash.my_each_with_index { |item, index| my_each_hash[item] = index }
      hash.each_with_index { |item, index| each_hash[item] = index }
      expect(my_each_hash).to eql(each_hash)
    end
    it 'returns the original object passsed to it ' do
      expect(range.my_each_with_index { |x| }).to eql(range)
    end
    it 'returns the enumerable object when  no block is passed' do
      expect(arr.my_each_with_index).to be_an_instance_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'iterates through an array and returns a new array of element matching the condition' do
      expect(arr.my_select { |x| x > 2 }).to eql(arr.select { |x| x > 2 })
    end
    it 'iterates through a range and returns a new array of element matching the condition' do
      expect(range.my_select { |x| x > 2 }).to eql(range.select { |x| x > 2 })
    end
    it 'returns the eneumerable object itself if no block passed' do
      expect(arr.my_select).to be_an_instance_of(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements saitisfy condition' do
      expect(arr.my_all? { |x| x > 0 }).to eql(arr.all? { |x| x > 0 })
    end
    it 'returns false if any elements cannot saitisfy condition' do
      expect(arr.my_all? { |x| x > 3 }).to eql(arr.all? { |x| x > 3 })
    end
    it 'Accepts pattern without block' do
      expect(arr.my_all?(Numeric)).to eql(arr.all?(Numeric))
    end
    it 'Returns true if Empty array passed without block' do
      expect([].my_all?).to eql([].all?)
    end
    it 'Returns true if Range passed without block' do
      expect(range.my_all?).to eql(range.all?)
    end
    it 'Returns true if all element matches Regex' do
      expect(%w[act brace cat].my_all?(/c/)).to eql(%w[act brace cat].all?(/c/))
    end
    it 'Returns false if any element doesnot match Regex' do
      expect(%w[ant bear cat].my_all?(/d/)).to eql(%w[ant bear cat].all?(/d/))
    end
  end

  describe '#my_any?' do
    it 'returns false if no element saitisfy condition' do
      expect(arr.my_any? { |x| x < 0 }).to eql(arr.any? { |x| x < 0 })
    end
    it 'returns true if any element  saitisfy condition' do
      expect(arr.my_any? { |x| x > 2 }).to eql(arr.any? { |x| x > 2 })
    end
    it 'Accepts pattern as argument without block' do
      expect(arr.my_any?(String)).to eql(arr.any?(String))
    end
    it 'Returns false if Empty array passed without block' do
      expect([].my_any?).to eql([].any?)
    end
    it 'Returns true if Range passed without block' do
      expect(range.my_any?).to eql(range.any?)
    end
    it 'Returns false if no element is true without block [fasle, false], [false, nil]' do
      expect([false, nil].my_any?).to eql([false, nil].any?)
    end
    it 'Returns true if one element is true without block[fasle, true], [1, nil]' do
      expect([false, 1].my_any?).to eql([false, 1].any?)
    end
    it 'Returns true if one element matches Regex' do
      expect(%w[ant bear cat].my_any?(/c/)).to eql(%w[ant bear cat].any?(/c/))
    end
    it 'Returns false if no element matches Regex' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(%w[ant bear cat].any?(/d/))
    end
  end

  describe '#my_none' do
    it 'returns true if no element matches the condition' do
      expect(arr.my_none? { |x| x < 0 }).to eql(arr.none? { |x| x < 0 })
    end
    it 'returns false if any element matches the condition' do
      expect(arr.my_none? { |x| x > 2 }).to eql(arr.none? { |x| x > 2 })
    end
    it 'Accepts Pattern as argument without block' do
      expect(arr.my_none?(String)).to eql(arr.none?(String))
    end
    it 'Returns true if Empty array passed without block' do
      expect([].my_none?).to eql([].none?)
    end
    it 'Returns false if no element is true without block [fasle, false], [false, nil]' do
      expect([false, nil].my_none?).to eql([false, nil].none?)
    end
    it 'Returns false if one element matches Regex' do
      expect(%w[ant bear cat].my_none?(/c/)).to eql(%w[ant bear cat].none?(/c/))
    end
    it 'Returns true if no element matches Regex' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(%w[ant bear cat].none?(/d/))
    end
  end


end
