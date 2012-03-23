class Range
  def overlap?(range)
    return true if self.cover?(range.first)
    return true if self.cover?(range.last)
    return true if (self.first > range.first && self.last < range.last)

    false
  end
end