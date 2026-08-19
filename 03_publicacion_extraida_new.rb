require "gvl-tracing"

@likes = 0

def valor_del_contador
  @likes
end

def setear_contador(nuevo_valor)
  @likes = nuevo_valor
end

GvlTracing.start("03_publicacion_extraida.json") do
  10.times.map do
    Thread.new do
      1000.times do
        nuevo_valor = valor_del_contador
        setear_contador(nuevo_valor + 1)
      end
    end
  end.each(&:join)
end


puts @likes
