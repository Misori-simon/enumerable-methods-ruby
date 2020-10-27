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
    return to_enum(:my_each) unless block_given? 
    

    array = self.to_a
    (array.length).times  do |x|
      yield array[x], x
    end
  end
  self
end


