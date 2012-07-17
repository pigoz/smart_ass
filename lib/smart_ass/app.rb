class SmartAss::App
  def initialize(file)
    @ass  = SmartAss::Ass.new(file)
    @file = Pathname.new(file)
  end

  def run
    # function composition baby!
    write_ass_script replace_colors extract track
  end

  private
  def write_ass_script(ass_script)
    script_file_basename = "#{@file.basename(@file.extname)}.ass"
    File.open(@file.expand_path.dirname + script_file_basename, "w") {|f|
      f.puts(ass_script)
    }
  end

  def replace_colors(ass_script)
    ass_script.gsub(/&H[\da-zA-Z]{6,8}/) {|c| convert_color(c)}
  end

  def convert_color(c)
    color = SmartAss::RGBAColor.from_ass(c)

    bt601 = SmartAss::YCbCrConverter.new(:bt601)
    bt709 = SmartAss::YCbCrConverter.new(:bt709)

    ycbcr = bt601.to_ycbcr(*color.rgb_components)
    rgb = bt709.to_rgb(*ycbcr)

    puts "[cache color] hex: #{c}, rgb: #{color.rgb_components}, " \
         "ycbcr: #{ycbcr}, mangled-rgb: #{rgb}"

    SmartAss::RGBAColor.from_rgba(*rgb).to_ass
  end

  def track
    if @ass.tracks.size > 1
      track = ask_for_track
    elsif @ass.tracks.size == 1
      track = @ass.tracks[0]
    else
      puts "No ASS tracks found. Aborting."
      exit
    end
  end

  def ask_for_track
    puts "Please enter a track name - #{@ass.tracks.inspect}:"
    readline.to_i
  rescue
    puts "Invalid track provided. Try again."
    retry
  end

  def extract(track_id)
    @ass.extract(track_id)
  end
end
