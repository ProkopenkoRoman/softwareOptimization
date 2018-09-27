require 'csv'

stat = CSV.read('./population.csv') # [["a1", "b1"], ["a2", "b2"], ...]
stat = stat.collect {|i| i.last} # ["b1", "b2", ...]
stat = stat.collect {|i| i.to_f} # [b1, b2, ...]

puts 'Input operation:'
puts '1 - max value'
puts '2 - min value'
puts '3 - average value'
puts '4 - selective variance corrected'

operation = gets.chomp

case operation
	when "1"
		puts "max value = #{stat.max}" 
		exit
	when "2"
		puts "min value = #{stat.min}"
		exit
	when "3"
		average = stat.reduce(:+) / stat.size.to_f
		puts "Averege = #{average}"
		exit
	when "4"
		average = stat.reduce(:+) / stat.size.to_f #среднее значение
		selective_variance = 0.0 #выборочная дисперсия
		stat.each do |num|
			selective_variance += (num - average) ** 2 #**2 - возведение в квадрат
		end
		selective_variance /= stat.size.to_f; #нашли выборочную дисперсию
		
		selective_variance_corrected = 0.0 #исправленная выборочная дисперсия
		selective_variance_corrected = selective_variance * stat.size.to_f / (stat.size.to_f - 1)
		puts "selective variance corrected = #{selective_variance_corrected}"
		exit
	else
		puts "Invalid operation. Try again!"
		exit
end
