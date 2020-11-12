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

end
