cart = {}
hash = Hash.new

loop do 
  puts "Product name? "
  puts "(Type 'stop' to exit)"
  product = gets.chomp 
  break if product == "stop"
  print "Quantity? "
  quantity = gets.chomp.to_f
  print "Price per one? "
  price = gets.chomp.to_f
  
  cart[product] = {price => quantity}  
end

result = 0 
cart.each do |product, price_and_quantity|
  price = price_and_quantity.first[0]
  quantity = price_and_quantity.first[1]
  total_price = price * quantity
  puts "#{product}: #{quantity} x #{price}$ = #{total_price}$"
  result += total_price
end

puts "Total: #{result}$"