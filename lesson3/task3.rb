result = [0, 1] 
next_num = 1
while next_num < 100 do 
  result << next_num
  next_num = result[-1] + result[-2] 
end 

result 