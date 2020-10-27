module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    array = self.to_a
    for element in array
      yield element
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?


    array = self.to_a
    (array.length).times  do |x|
      yield array[x], x
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = self
    final_array = []
    for element in array
      final_array << element if yield element
    end
    final_array
  end
end

arr = {"messi" => 54, "ronaldo" => 55, "zidane" => 53, "fowler" => 78 }
p arr
p arr.select { |num, y|  num == "messi"  }
p arr.my_select { |num, y|  num == "messi"  }
