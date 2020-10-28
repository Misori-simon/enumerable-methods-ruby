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
    final_object = []   if self.class == Array
    final_object = {}   if self.class == Hash
    for element in array
      if final_object.class == Array
       final_object << element if yield element
      else
        final_object[element[0]] = element[1] if yield element
      end

    end
    final_object
  end

  def my_all?

    return result = true unless block_given?
    for element in self
      result = false unless yield element
    end
    return result
  end

  def my_any?
    return result = true unless block_given?

    result = false

    for element in self
      result = true if  yield element
    end
    result
  end

  def my_none?

    unless block_given?
      return true unless self.any? {|element| element == true}
      return false
    end

    for element in self
      return false if yield element
    end
    return true

  end

  def my_count(arg = nil)
    return self.length if !(block_given?) && arg == nil
    counter = 0
    for element in self
      if arg
        if arg == element
          counter +=1
        end
      elsif yield element
        counter +=1
      end
    end
    return counter
  end

  def my_map
    return to_enum(:map) unless block_given?
  
    final_object = []
    for element in self
      final_object << (yield element)
    end
    final_object
  end

end


