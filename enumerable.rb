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


end
