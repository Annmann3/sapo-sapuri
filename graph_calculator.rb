require 'byebug'

class PoOneCompVc
  attr_accessor :vdf, :d, :ka, :ke, :lag_time

  def initialize(vdf, d, ka, ke, lag_time)
    @vdf = vdf
    @d = d
    @ka = ka
    @ke = ke
    @lag_time = lag_time
  end

  def get_vc_graph(t)
    self.vdf * self.d * self.ka * Math.exp(-self.ka * t) * t
  end
end
byebug
vc = PoOneCompVc.new(1.0/35, 1000, 0.33, 0.33, 0)

puts 'hello'
