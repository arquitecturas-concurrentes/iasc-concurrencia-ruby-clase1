@likes = 0
@lock = Mutex.new

def valor_del_contador
  @likes
end

def setear_contador(nuevo_valor)
  @likes = nuevo_valor
end

100.times.map do
  Thread.new do
    100_000.times do
      @lock.synchronize do
        nuevo_valor = valor_del_contador
        setear_contador(nuevo_valor + 1)
      end
    end
  end
end.each(&:join)

puts @likes
