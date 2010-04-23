require "rubygems"
require "memcached"
require "benchmark"
# this benchmark is intended to represent a fairly typical workload
# for a rails app: talk to memcache, make some method calls, concat
# some strings.
class PageBenchmark
  def initialize
    @mc = Memcached.new("localhost:11211")
    1000.times do |i|
      @mc.set("page_benchmark#{i}", i.to_s * 500)
    end
  end

  def network_call
    # this should be memcache, but I have not the patience right now
    Net::HTTP.get(URI.parse("http://127.0.0.1"))
  end

  def run(h)
    opts = {
      :memcache_calls => 100,
      :method_calls => 2000,
      :strings => 300,
      :string_size => 300
    }.merge(h)
    Benchmark.realtime do
      result = ""
      str = ""
      opts[:memcache_calls].times { str += network_call }
      opts[:method_calls].times { Target.even?(100) }
      opts[:strings].times { result += str[0..opts[:string_size]]}
    end
  end
end

class Target
  def self.even?(int)
    if 0 == int
      true
    else
      odd?(int - 1)
    end
  end

  def self.odd?(int)
    if 0 == int
      false
    else
      even?(int - 1)
    end
  end
end

PageBenchmark.new.run({ :memcache_calls => 1000,
                        :method_calls => 2000,
                        :strings => 3000,
                        :string_size => 300})
