hh = {}

loop do
  print 'Enter product id: '
  id = gets.chomp

  print 'Enter amountof items you want to order: '
  n = gets.chomp.to_i

  x = hh[id].to_i #read hash value (o if it's not exists)
  x = x + n #increase by n
  hh[id] = x#set hash value

  puts hh.inspect

  #calculates total number of items in the cart
  total = 0
  hh.each do |key, value|
    total = total + value
  end

  #puts total variable
  puts "total items in cart: #{total}"

end
