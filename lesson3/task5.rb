print "day? "
day = gets.to_i
print "month? "
month = gets.to_i
print "year? "
year = gets.to_i

month_days = { "1" => 31,
               "2" => 28,
               "3" => 31,
               "4" => 30,
               "5" => 31,
               "6" => 30,
               "7" => 31,
               "8" => 31,
               "9" => 30,
               "10" => 31,
               "11" => 30,
               "12" => 31
 }

is_leap_year = not(year % 4 != 0 || (year % 100 == 0 && year % 400 != 0))
month_days["2"] = 29 if is_leap_year

result = 0
month_days.each do |month_num, days_in_month|
  if month_num.to_i < month 
    result += days_in_month 
  elsif month_num.to_i == month 
    result += day 
  end
end

result

 