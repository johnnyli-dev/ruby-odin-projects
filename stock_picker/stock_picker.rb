def stock_picker(days)
    results = days.each_with_index.to_a.combination(2).max_by{|buy,sell| sell[0]-buy[0]}.map {|price, day| day}
    #each with index will put the days and prices together
    #to_a makes each an array with combination
    #max_by will figure out the max amounts by prices
    #and .map at the end will convert the day and price to just the day
    puts results
end


stock_picker([17,3,6,9,15,8,6,1,10])
