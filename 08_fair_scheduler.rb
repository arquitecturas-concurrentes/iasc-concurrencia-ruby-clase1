##  check json on https://ui.perfetto.dev/
require "gvl-tracing"

GvlTracing.start("08_fair_scheduler.json") do
  def busy_work(id)
    5.times do |i|
      # do heavy CPU work
      50_000_000.times { Math.sqrt(12345) }
      puts "Thread #{id} finished iteration #{i}"
    end
  end

  threads = []


  2.times do |i|
    threads << Thread.new { busy_work(i) }
  end

  threads.each(&:join)
end
