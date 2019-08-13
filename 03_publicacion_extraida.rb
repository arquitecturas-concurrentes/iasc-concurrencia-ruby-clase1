@likes = 0

def valor_del_contador
  @likes
end

def setear_contador(nuevo_valor) 
  @likes = nuevo_valor
end

100.times.map do
  Thread.new do
    100_000.times do
      nuevo_valor = valor_del_contador()
      setear_contador(nuevo_valor + 1 )
    end
  end
end.each(&:join)

puts @likes
