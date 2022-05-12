require 'byebug'

num = 2
result = `python ./array_tesy.py #{num}`
byebug
puts 'Rubyresult'
p result
