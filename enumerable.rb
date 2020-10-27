module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    to_a
    each(&block)
    self
  end
end
