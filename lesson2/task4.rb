puts "Solver for equiation ax^2 + bx + c = 0"
print "a = "
a = gets.to_f
print "b = "
b = gets.to_f
print "c = "
c = gets.to_f

d = b**2 - 4*a*c

if d < 0 
  puts "no roots!"
elsif d == 0 
  x = -b / (2 * a)
  puts "root is #{x.ceil(2)}"
else 
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "first root is #{x1.ceil(2)}"
  puts "second root is #{x2.ceil(2)}"
end