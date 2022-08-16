require 'byebug'
require 'active_support'
require 'active_support/core_ext'
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

  def draw_24hours(start = Time.now)
    blood_list = []
    (24*60).times do |n|
      data = [start + n.minute, get_vc_graph(n / 60.0)]
      blood_list.push(data)
    end
    blood_list
  end
end
vc = PoOneCompVc.new(1.0/35, 1000, 0.33, 0.33, 0)

byebug
puts 'hello'
