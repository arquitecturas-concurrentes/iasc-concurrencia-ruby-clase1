#https://github.com/ruby/ruby/commit/1403dfbf317ad796d92518bf5a7cbc40f2912dff
likes = 0

100.times.map do
  Thread.new do
    100_000.times do
      nuevo_valor = likes
      nuevo_valor = nuevo_valor + 1 
      likes = nuevo_valor unless false
    end
  end
end.each(&:join)

puts likes