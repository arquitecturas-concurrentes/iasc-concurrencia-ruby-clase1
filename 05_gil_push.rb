comentarios = []

100.times.map do
  Thread.new do
    100_000.times do |comentario|
      comentarios.push comentario
    end
  end
end.each(&:join)

puts comentarios.size