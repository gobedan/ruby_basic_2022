puts "Your name?"
name = gets.chomp

puts "Your heigh? (in sm)"
height = gets.chomp

puts "Your ideal weight is #{(height.to_i - 110) * 1.15} kg"