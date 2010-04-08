if Target.foo(1,2)
  true
elsif Target.new.foo(a, b)
  false
else
  nil
end

while 1 < 0
  puts "never reach this code"
end

10.times { |x| x.class }
