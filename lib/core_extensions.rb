class String
  def first
    self[0].chr
  end

  def last
    self[-1].chr
  end

  def wrap_with(wrapper)
    if wrapper.length == 2
      wrapper.first + self + wrapper.last
    elsif wrapper.length == 1
      wrapper + self + wrapper
    else
      raise "bad argument"
    end
  end
end

class Array
  def to_comma_list
    self.join(", ").wrap_with("()")
  end

  def wrap_with(wrapper)
    if wrapper.length == 2
      wrapper.first.to_a + self + wrapper.last.to_a
    elsif wrapper.length == 1
      wrapper.to_a + self + wrapper.to_a
    else
      raise "bad argument"
    end
  end
end
