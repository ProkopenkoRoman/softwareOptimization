def fibonacci(n)
    if n < 3
        1
    else
        fibonacci(n - 1) + fibonacci(n - 2)
    end
end

puts 'Input number of months: '
month = gets.chomp

puts 'couples of rabbits: '  
puts fibonacci(month.to_i + 2)
