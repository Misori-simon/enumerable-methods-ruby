# Implementation of Ruby's Magical Enumerable Methods

## Definition

Enumeration refers to traversing over objects. In Ruby, we call an object enumerable when it describes a set of items and a method to loop over each of them.

The built-in enumerables get their enumeration features by including the Enumerable module, which provides methods like #include?, #count, #map, #select and #uniq, amongst others. Most of the methods associated with arrays and hashes aren’t actually implemented in these classes themselves, they’re included. 

## About the Project

In this project, we have implemented the following enumerable methods:
- _each_ method as _my_each_
- _each_with_index_ as _my_each_with_index_
- _select as _my_select_
- _all?_ as _my_all?_
- _any?_ as _my_any?_
- _none?_ as _my_none?_
- _count_ as _my_count_
- _map_ as _my_map_
- _inject_ as _my_inject_
- _multiply_els_ this is our own method to test the _my_inject_ method

## Built With

 Ruby Programming Language

## Live Demo

[Live Demo Link](https://repl.it/@smcommits/EnumerableMethods#main.rb)


## Getting Started

**To run the program on your local machine, follow the steps below.**

```
git clone https:https://github.com/Misori-simon/enumerable-methods-ruby
```

```
cd enumerable-methods-ruby
```

```
ruby test.rb
```

**Example Case**

To test any particular method, do it the following way. We are running my_inject method
```
[1,2,3,4].my_inject(:+)
```
The output
```
10
```


## Authors

👤 **Anas Siddiqui**

- GitHub: [Anas Siddiqui](https://github.com/smcommits)


👤 **Misori Simon**

  - GitHub: [Misori-simon](https://github.com/Misori-simon/)
  - Twitter: [@misori_simon](https://twitter.com/misori_simon)
  - LinkedIn: [Misori Simon](https://cm.linkedin.com/in/misori-simon-05906219b)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!


