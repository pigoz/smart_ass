class SmartAss::RGBAColor
  attr_reader :r, :g, :b, :a

  def self.from_ass(string)
    argb_hex = string.gsub(/^&H/, '')
    from_argb(*argb_hex.scan(/.{2}/).map {|h| h.to_i(16)})
  end

  def self.from_argb(*components)
    from_rgba(*components.push(components.shift))
  end

  def self.from_rgba(*components)
    new(*components)
  end

  def initialize(r, g, b, a)
    @r, @g, @b, @a = r, g, b, a
  end

  def components
    [@r, @g, @b, @a]
  end

  def to_ycbcr(colormatix)
  end
end
