require 'pathname'

class SmartAss::InputFile
  attr_reader :file

  def initialize(file)
    @file = Pathname.new(file)
  end

  def stream
    IO.read(@file)
  end

  def self.types
    [:mkv, :ass]
  end

  def self.from_type(type, file)
    klass(type).new(file)
  end

  def self.klass(kind)
    case kind
    when :mkv
      SmartAss::MKV
    when :ass
      SmartAss::InputFile
    else
      raise "Unrecognized kind=#{kind}"
    end
  end
end
