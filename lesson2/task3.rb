print "Triangle side A = "
side_a = gets
print "Triangle side B = "
side_b = gets
print "Triangle side C = "
side_c = gets

sides = [side_a.to_f, side_b.to_f, side_c.to_f] 
max_side = sides.sort!.pop

if (side_a == side_b) && (side_b == side_c)
    puts "Triangle is perfect"
elsif (side_a == side_b) || (side_b == side_c) || (side_a == side_c)
    puts "Triangle is equal-sided"
elsif  max_side ** 2 == sides.inject(0) {|sum, n| sum + n**2}
    puts "Traingle is normal"
end

