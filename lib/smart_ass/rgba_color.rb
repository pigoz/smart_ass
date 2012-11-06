class SmartAss::RGBAColor
  attr_reader :r, :g, :b, :a

  def self.from_ass(string)
    abgr_hex   = string.gsub(/^&H/, '')
    components = abgr_hex.scan(/.{2}/).map {|h| h.to_i(16)}

    if components.size >= 4
      from_abgr(*components)
    else
      from_bgr(*components)
    end
  end

  def self.from_abgr(*components)
    argb = [components[0], components[1..3].reverse].flatten
    from_argb(*argb)
  end

  def self.from_bgr(*components)
    from_rgba(*components.reverse)
  end

  def self.from_argb(*components)
    from_rgba(*components.push(components.shift))
  end

  def self.from_rgba(*components)
    new(*components)
  end

  def to_ass
    hex = abgr_components
      .map {|c| c.to_s(16)}
      .map {|c| c.rjust(2, "0")}
      .map(&:upcase)
      .join
    "&H#{hex}"
  end

  def initialize(r, g, b, a=0x00)
    @r, @g, @b, @a = [r, g, b, a].map {|n| n < 0 ? 0 : n}
  end

  def components
    [@r, @g, @b, @a]
  end

  def argb_components
    c = components
    c.unshift(c.pop)
  end

  def abgr_components
    argb = argb_components
    [argb[0], argb[1..3].reverse].flatten
  end

  def rgb_components
    c = components
    c.pop
    c
  end
end
