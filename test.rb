# rubocop: disable all
require_relative "enumerable.rb"

puts
puts
puts "****************************************"
puts "MY EACH"
puts "****************************************"
[1, 2, 3, 5].my_each { |x| p x }
puts "SEPARATOR"
[1, 2, 3, 5].each { |x| p x } #compare

h = {foo: 0, bar: 1, baz: 2}
h.each {|key, value| p "#{key}: #{value}"}  #=> foo: 0bar: 1baz: 2
h.my_each {|key, value| p "#{key}: #{value}"}  #=> 0: 1: 2:
puts
puts
puts "****************************************"
puts "MY EACH WITH INDEX"
puts "****************************************"
[1, 2, 3, 5].my_each_with_index { |x, y| puts "#{x} at #{y}" }
puts "SEPARATOR"
[1, 2, 3, 5].each_with_index { |x, y| puts "#{x} at #{y}" }#compare
puts
h = {foo: 0, bar: 1, baz: 2}

#each_with_index

hash = Hash.new
h.each_with_index { |item, index|
  hash[item] = index
}

p hash  #=> {[:foo, 0]=>0, [:bar, 1]=>1, [:baz, 2]=>2}

#my_each_with_index

hash = Hash.new
h.my_each_with_index { |item, index|
  hash[item] = index
}

p hash #=> {0=>0, 1=>1, 2=>2}
puts
puts "****************************************"
puts "MY SELECT"
puts "****************************************"
p [1, 2, 3, 4].my_select { |x| x % 2 == 0}
puts
p [1, 2, 3, 4].select { |x| x % 2 == 0 }#compare
puts
p (1..10).my_select { |i|  i % 3 == 0 }   #=> [3, 6, 9]
puts
p (1..10).select { |i|  i % 3 == 0 }   #=> [3, 6, 9]
puts
p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]
puts
p [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
puts
p [:foo, :bar].my_select { |x| x == :foo }   #=> [:foo]
puts
p [:foo, :bar].select { |x| x == :foo }   #=> [:foo]
puts
puts
puts
puts "****************************************"
puts "MY ALL"
puts "****************************************"
p ['alpha', 'apple', 'allen key'].my_all?{ |x| x[0] == 'a' }
p ['alpha', 'apple', 'allen key'].all?{ |x| x[0] == 'a' }
puts "SEPARATOR"
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
puts "SEPARATOR"
p %w[ant bear cat].my_all?(/t/)                        #=> false
p %w[ant bear cat].all?(/t/)                        #=> false
puts "SEPARATOR"
p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
p [1, 2i, 3.14].all?(Numeric)                       #=> true
puts "SEPARATOR"
p [nil, true, 99].my_all?                              #=> false
p [nil, true, 99].all?   
puts "SEPARATOR"
p [].all?  #=> true
p [].my_all?  #=> false
puts "SEPARATOR"
p (0..5).all?  #=> true
p (0..5).my_all?  #=> false                           #=> false
puts
puts
puts


puts
puts
puts "****************************************"
puts "MY ANY"
puts "****************************************"
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
puts "SEPARATOR"
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
puts "SEPARATOR"
p %w[ant bear cat].my_any?(Integer)                        #=> false
p %w[ant bear cat].any?(Integer)                        #=> false
puts "SEPARATOR"
p [nil, true, 99].my_any?(Integer)                     #=> true
p [nil, true, 99].any?(Integer)                     #=> true
puts "SEPARATOR"
p [nil, true, 99].my_any?                              #=> true
p [nil, true, 99].any?                              #=> true
puts "SEPARATOR"
p [].my_any?                                           #=> false
p [].any?  
puts "SEPARATOR"   
puts (0..5).any?   #=> true
puts (0..5).my_any?  #=> my_methods.rb:89:in `block in my_any?': no block given (yield) (LocalJumpError)
puts "SEPARATOR"
puts [false, nil].any?   #=> true
puts [false, nil].my_any?  #=> my_methods.rb:89:in `block in my_any?': no block given (yield) (LocalJumpError)
puts "SEPARATOR"
puts [false, false].any?   #=> true
puts [false, false].my_any?  #=> my_methods.rb:89:in `block in my_any?': no block given (yield) (LocalJumpError)
puts "SEPARATOR"
#  in the case below it checks if any word has a letter d.
puts %w[ant bear cat].any?(/d/)    #=> false
puts %w[ant bear cat].my_any?(/d/)   #=> true                                      #=> false
puts "SEPARATOR"
#  in the case below it checks if any word has a letter d.
puts %w[ant bear cat].any?(/c/)    #=> false
puts %w[ant bear cat].my_any?(/c/)   #=> true                                      #=> false
puts "****************************************"
puts "SEPARATOR"
#  in the case below it checks if any word has a letter d.
puts %w[ant bear cat].any?(/cat/)    #=> false
puts %w[ant bear cat].my_any?(/cat/)   #=> true                                      #=> false
puts "****************************************"
puts
puts
puts
puts
puts "****************************************"
puts "MY NONE"
puts "****************************************"
p ['Alpha', 'Apple', 'Allen key'].my_none?{ |x| x[0] == 'a' }
p ['lpha', 'pple', 'llen key'].none?{ |x| x[0] == 'a' }
puts "SEPARATOR"
class DeathCab
end
plans = DeathCab.new()
p [1, 3.14, 42].my_none?(String)  # => output false
p [1, 3.14, 42].none?(String)  # => output false
puts  "SEPARATOR"
p ["BY" "FIRE" "BE" "PURGED", %w[DIE INSECT].to_enum].my_none?(Enumerable)  # => output false
p ["BY" "FIRE" "BE" "PURGED", %w[DIE INSECT].to_enum].none?(Enumerable)  # => output false
puts "SEPARATOR"
p ["With", "eyes", "like", "the", "summer", 3].my_none?(Float)  # => output true
p ["With", "eyes", "like", "the", "summer", 3].none?(Float)  # => output true
puts "SEPARATOR"
p [1.12, 3.14, 3.15].my_none?(String)  # => output true
p [1.12, 3.14, 3.15].none?(String)  # => output true
puts "SEPARATOR"
p [plans, plans, plans].my_none?(DeathCab)  # => output false
p [plans, plans, plans].none?(DeathCab)  # => output false
puts "SEPARATOR"

puts %w{ant bear cat}.none?(/d/)    #=> true
puts %w{ant bear cat}.my_none?(/d/)  #=> false
puts "SEPARATOR"
puts [nil, false, true].none?          #=> false
puts [nil, false, true].my_none?   #=> true
puts "SEPARATOR"
puts [nil, false, false].none?          #=> false
puts [nil, false, false].my_none?   #=> true
puts "SEPARATOR"
puts (0..4).none?    #=> false
puts (0..4).my_none?  #=> true
puts
puts
puts "****************************************"
puts "MY COUNT"
puts "****************************************"
arr = [1, 2, 3, 4, 4]
p arr.my_count { |i| i%2==0}
p arr.count { |i| i%2==0}
puts "SEPARATOR"
p arr.my_count               # => 5
p arr.count               # => 5
puts "SEPARATOR"
p [1,2,3,4,4,7,7,7,9].my_count { |i| i > 1 }
p [1,2,3,4,4,7,7,7,9].count { |i| i > 1 }
puts
puts
puts
puts
puts "****************************************"
puts "MY Map"
puts "****************************************"
p [1,2,3,4,4,7,7,7,9].my_map { |i| i*4 }
p [1,2,3,4,4,7,7,7,9].map { |i| i*4 }
puts "SEPARATOR"
p (1..4).my_map { |i| i*i }
p (1..4).map { |i| i*i }
puts "SEPARATOR"
p (1..4).my_map { "cat"  }
p (1..4).map { "cat"  }
puts "SEPARATOR"
p [1, 2, 3].my_map(&:to_s)
p [1, 2, 3].map(&:to_s)
puts "SEPARATOR"
my_proc = Proc.new { |i| i*4 }
p [1,2,3,4,4,7,7,7,9].my_map { |i| i*4 }
p [1,2,3,4,4,7,7,7,9].my_map(&my_proc)
puts
puts
puts
puts
puts "****************************************"
puts "MY Inject"
puts "****************************************"
# p [1,2,3,4,4,7,7,7,9].my_inject #ERROR
puts "SEPARATOR"
p [1,2,3,4,4,7,7,7,9].my_inject(0){|running_total, item| running_total + item }
p [1,2,3,4,4,7,7,7,9].inject(0){|running_total, item| running_total + item }
puts "SEPARATOR"
p (5..10).my_inject(:+)
p (5..10).inject(:+)
puts "SEPARATOR"
p (5..10).my_inject { |sum, n| sum + n }
p (5..10).inject { |sum, n| sum + n }
puts "SEPARATOR"
p (5..10).my_inject(1, :*)
p (5..10).inject(1, :*)
puts "SEPARATOR"
p (5..10).my_inject(1) { |product, n| product * n }
p (5..10).inject(1) { |product, n| product * n }
puts "SEPARATOR"
p [2,4,5].my_inject(:*) #POINT NUMBER 10
p [2,4,5].inject(:*) #POINT NUMBER 10
puts
longest = %w{ cat sheep bear }.my_inject do |memo, word|
 memo.length > word.length ? memo : word
end
p longest
puts
longest = %w{ cat sheep bear }.inject do |memo, word|
 memo.length > word.length ? memo : word
end
p longest



p multiply_els([2,4,5])
