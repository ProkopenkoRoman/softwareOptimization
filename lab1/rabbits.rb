def fibonacci(n)
    if n < 3
        1
    else
        fibonacci(n - 1) + fibonacci(n - 2)
    end
end

puts 'Input number of months: '
month = gets.chomp
if month.to_i == 0 || month.to_i < 1
	puts 'Invalid value.. Try again!'
	exit
end

puts 'couples of rabbits: '  
puts fibonacci(month.to_i + 2)
