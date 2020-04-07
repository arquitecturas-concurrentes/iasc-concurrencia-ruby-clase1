@likes = 0
@lock = Mutex.new

def valor_del_contador
  @lock.synchronize do
    @likes
  end  
end

def setear_contador(nuevo_valor)
  @lock.synchronize do
    @likes = nuevo_valor
  end  
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
