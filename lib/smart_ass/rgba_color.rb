class SmartAss::RGBAColor
  attr_reader :r, :g, :b, :a

  def self.from_ass(string)
    argb_hex = string.gsub(/^&H/, '')
    components = argb_hex.scan(/.{2}/).map {|h| h.to_i(16)}
    if components.size == 4
      from_argb(*components)
    else
      from_rgba(*components)
    end
  end

  def self.from_argb(*components)
    from_rgba(*components.push(components.shift))
  end

  def self.from_rgba(*components)
    new(*components)
  end

  def to_ass
    hex = argb_components
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

  def rgb_components
    c = components
    c.pop
    c
  end
end
