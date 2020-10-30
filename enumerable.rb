# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/MethodLength
# rubocop: disable Metrics/CyclomaticComplexity
# rubocop: disable Metrics/PerceivedComplexity
# rubocop: disable Style/IdenticalConditionalBranches
# rubocop: disable Style/CaseEquality
# rubocop: disable Style/ExplicitBlockArgument

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    array = to_a
    array.each do |element|
      yield element
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    array = to_a
    array.length.times do |x|
      yield array[x], x
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = self
    array = to_a if instance_of?(Range)
    final_object = [] if array.instance_of?(Array)
    final_object = {} if array.instance_of?(Hash)
    array.each do |element|
      if final_object.instance_of?(Array)
        final_object << element if yield element
      elsif yield element
        final_object[element[0]] = element[1]
      end
    end
    final_object
  end

  def my_all?(pattern = nil)
    unless block_given? || pattern
      return my_any? { |x| x == false } ? false : true
    end

    result = true

    if pattern
      if pattern.is_a?(Regexp)
        my_each { |element| result = false unless element.match(pattern) }
        return result
      else
        my_each { |element| result = false unless pattern === element }
        return result
      end
    end

    my_each { |element| result = false unless yield element }
    result
  end

  def my_any?(pattern = nil)
    unless block_given? || pattern
      my_each do |element|
        return element ? true : false
      end
    end

    result = false

    if pattern
      if pattern.is_a?(Regexp)
        my_each do |element|
          return true if element.match(pattern)
        end
        return false

      else
        my_each do |element|
          return true if pattern === element
        end
        return false
      end
    end

    each do |element|
      result = true if yield element
    end
    result
  end

  def my_none?(pattern = nil)
    unless block_given? || pattern
      return true unless any? { |element| element == true }

      return false
    end

    if pattern
      if pattern.is_a?(Regexp)
        my_each do |element|
          return false if element.match(pattern)
        end
        return true

      else
        my_each do |element|
          return false if pattern === element
        end
        return true
      end
    end

    each do |element|
      return false if yield element
    end
    true
  end

  def my_count(arg = nil)
    return length if !block_given? && arg.nil?

    counter = 0
    each do |element|
      if arg
        counter += 1 if arg == element
      elsif yield element
        counter += 1
      end
    end
    counter
  end

  def my_map(&proc)
    return to_enum(:map) unless block_given?

    final_object = []
    each do |element|
      final_object << (proc.call(element))
    end
    final_object
  end

  def my_inject(accumulator = nil, symbol = nil, &block)
    raise LocalJumpError, 'no block given?' if accumulator.nil? && symbol.nil? && block.nil?

    raise LocalJumpError, 'provide either a symbol or a block' if symbol && block

    if symbol.nil? && block.nil?
      symbol = accumulator
      accumulator = nil
    end

    array = to_a

    code_to_run = case symbol
                  when Symbol
                    ->(acc, element) { acc.send(symbol, element) }
                  when nil
                    block
                  end

    if accumulator.nil?
      ignore_first_element = true
      accumulator = array[0]
    end

    switch = 0

    each do |element|
      accumulator = code_to_run.call(accumulator, element) unless ignore_first_element && switch.zero?
      switch += 1
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

# rubocop: enable all
