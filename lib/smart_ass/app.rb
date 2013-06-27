class SmartAss::App
  def initialize(options, file)
    if options.type == :ass and not options.suffix
      raise "Please provide a suffix for the output file!"
    end

    @ass           = SmartAss::InputFile.from_type(options.type, file)
    @output_suffix = options.suffix
    @file          = Pathname.new(file)
  end

  def run
    # function composition baby!
    write_ass_script replace_colors @ass.stream
  end

  private
  def write_ass_script(ass_script)
    File.open(@file.expand_path.dirname + output_file_basename, "w") {|f|
      f.puts(ass_script)
    }
  end

  def output_file_basename
    name = [
      @file.basename(@file.extname),
      @output_suffix
    ].select{|a| a}.join('-')

    "#{name}.ass"
  end

  def replace_colors(ass_script)
    ass_script.gsub(/&H[\da-zA-Z]{6,8}/) {|c| convert_color(c)}
  end

  def convert_color(c)
    @_colors_cache ||= Hash.new

    unless @_colors_cache[c]
      color = SmartAss::RGBAColor.from_ass(c)

      bt601 = SmartAss::YCbCrConverter.new(:bt601)
      bt709 = SmartAss::YCbCrConverter.new(:bt709)

      ycbcr = bt601.to_ycbcr(*color.rgb_components)
      rgb = bt709.to_rgb(*ycbcr)

      puts "[converted color] ass-hex: #{c}, rgb: #{color.rgb_components}, " \
           "ycbcr: #{ycbcr}, mangled-rgb: #{rgb}"

      @_colors_cache[c] = SmartAss::RGBAColor.from_rgba(*rgb).to_ass
    end

    @_colors_cache[c]
  end
end
