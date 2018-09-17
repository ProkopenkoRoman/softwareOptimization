print 'Enter a value of temperature: '
val = gets.chomp
if (!(val == '0') && val.to_f == 0)
	print 'Invalid value! Try again!'
	exit
end

print 'Enter the first scale (C, K, F): '
scale1 = gets.chomp
scale1 = scale1.downcase
unless scale1 == 'c' || scale1 == 'k' || scale1 == 'f'
  print 'Invalid scale! Try again!'
  exit
end

print 'Enter the second scale for conversation (C, K, F): '
scale2 = gets.chomp
scale2 = scale2.downcase
unless scale2 == 'c' || scale2 == 'k' || scale2 == 'f'
  print 'Invalid scale! Try again!'
  exit
end

if scale1 == scale2
  print 'Scales equal! Try again!!'
  exit
end

if scale1 == 'c' && scale2 == 'k'
  p val.to_f + 273
elsif scale1 == 'c' && scale2 == 'f'
  p val.to_f * 1.8 + 32
elsif scale1 == 'k' && scale2 == 'c'
  p val.to_f - 273
elsif scale1 == 'k' && scale2 == 'f'
  p (val.to_f - 273) * 1.8 + 32
elsif scale1 == 'f' && scale2 == 'c'
  p (val.to_f - 32) / 1.8
elsif scale1 == 'f' && scale2 == 'k'
  p (val.to_f - 32) / 1.8 + 273
end 
