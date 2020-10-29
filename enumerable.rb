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

  def my_all?(pattern = nil)

    unless block_given? || pattern
     return (self.my_any? {|x| x == false}) ? false : true
    end

    result =  true

    if pattern
     if pattern.is_a?(Regexp)
      self.my_each {|element| result = false unless element.match(pattern)}
      return result
     else
      self.my_each {|element| result = false unless pattern === element}
      return result
     end
    end

    self.my_each {|element| result = false unless yield element }
    return result
  end

  def my_any?(pattern = nil)

    unless block_given? || pattern
      self.my_each do |element|
        return element ? true : false
      end
    end

    result = false

    if pattern
     if pattern.is_a?(Regexp)
      self.my_each  do |element| 
        return true if element.match(pattern) 
      end
      return false

     else
      self.my_each do |element| 
        return true if pattern === element
      end
      return false
     end
    end

    for element in self
      result = true if  yield element
    end
    result
  end

  def my_none?(pattern = nil)

    unless block_given? || pattern 
      return true unless self.any? {|element| element == true}
      return false
    end

    if pattern
     if pattern.is_a?(Regexp)
      self.my_each  do |element| 
        return false if element.match(pattern) 
      end
      return true

     else
      self.my_each do |element| 
        return false if pattern === element
      end
      return true
     end
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

  def my_map(&proc)
    return to_enum(:map) unless block_given?

    final_object = []
    for element in self
      final_object << (proc.call(element))
    end
    final_object
  end


def my_inject(accumulator = nil, symbol = nil, &block)

  if accumulator.nil? && symbol.nil? && block.nil?
    raise LocalJumpError, "no block given?"
  end

  if symbol && block
    raise LocalJumpError, "provide either a symbol or a block"
  end

  if symbol.nil? && block.nil?
    symbol = accumulator
    accumulator = nil
  end

  array = self.to_a

  code_to_run = case symbol
    when Symbol
      lambda { |accumulator, element| accumulator.send(symbol, element) }
    when nil
      block
  end

  if accumulator.nil?
    ignore_first_element = true
    accumulator = array[0]
  end

  switch = 0

  each do |element|
    unless ignore_first_element && switch == 0
      accumulator = code_to_run.call(accumulator, element)
    end
    switch += 1
  end
  accumulator
end

end

def multiply_els(arr)
  arr.my_inject(:*)
end

