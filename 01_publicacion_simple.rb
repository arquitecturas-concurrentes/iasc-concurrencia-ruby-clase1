@likes = 0

100.times.map do
  Thread.new do
    100_000.times do
      @likes += 1
    end
  end
end.each(&:join)

puts @likes