@likes = 0

1000.times.map do
  Thread.new do
    100.times do
      nuevo_valor = @likes
      nuevo_valor = nuevo_valor + 1
      @likes = nuevo_valor
    end
  end
end.each(&:join)

puts @likes
