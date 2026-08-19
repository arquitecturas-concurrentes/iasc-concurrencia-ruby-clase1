require "gvl-tracing"
@likes = 0

GvlTracing.start("01_publicacion_simple.json") do
  100.times.map do
    Thread.new do
      10000.times do
        @likes += 1
      end
    end
  end.each(&:join)
end

puts @likes