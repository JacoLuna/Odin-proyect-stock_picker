def stock_picker(stocks_prices)
    results = Array.new
    stocks_prices.each_index do |index|
        results.push(highestProfit(stocks_prices, index))
    end

    max = 0
    stockPicked = Array.new(2)

    results.each do |value|
        if(max == 0 || value[:profit].to_f > max)
            max = value[:profit].to_f
            stockPicked[0] = value[:buyIndex].to_i
            stockPicked[1] = value[:sellIndex].to_i
        end
    end

    stockPicked
end

=begin
buy = the starting point, meaning i buy on that day
sellIndex = the index of the day where i will be selling ignoring all the values that are already on a previous day, [...index] goes from the beginning up until the index exclusive
sell = the higest value to sell always ignoring previous days, because i cant buy on the past thats why i do [index..] this makes the array starts at index intead of 0 so the max value will be search for starting at the index
=end
def highestProfit(stocks_prices, index)
    buy = stocks_prices[index..][0]
    sellIndex = findHighestIndex(stocks_prices, stocks_prices[...index])
    sell = stocks_prices[index..].max()
    {:buyIndex => index, :sellIndex => sellIndex, :profit =>  sell - buy}
end

def findHighestIndex(array, excludedValue = Array.new, excludedIndex = Array.new)
    flag = false
    highestValue = 0
    highestIndex = -1
    array.each_with_index do |stock, i|
        if (!excludedValue.include?(stock) && !excludedIndex.include?(i) && (!flag || stock > highestValue)) 
            flag = true
            highestValue = stock
            highestIndex = i
        end
    end
    highestIndex
end

#i do the to_s so it looks nicer
puts stock_picker([17,3,6,9,15,8,6,1,10]).to_s