mapa = java.util.HashMap.new
executor = java.util.concurrent.Executors.newFixedThreadPool(20)
500.times do
  executor.execute { mapa["foo"] = 1 }
  executor.execute { mapa["foo"] = 2 }
  executor.execute { mapa["foo"] = 3 }
  executor.execute { puts mapa["foo"] }
end