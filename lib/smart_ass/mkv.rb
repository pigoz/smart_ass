class SmartAss::MKV < SmartAss::InputFile
  def stream
    extract track
  end

  def track
    if tracks.size > 1
      track = ask_for_track
    elsif tracks.size == 1
      track = tracks[0]
    else
      puts "No ASS tracks found. Aborting."
      exit
    end
  end

  def tracks
    identify.each_line \
      .map    {|l| (l =~ identify_ass_regexp) ? $1 : nil } \
      .compact \
      .map(&:to_i)
  end

  private
  def ask_for_track
    puts "Please enter a track name - #{tracks.inspect}:"
    readline.to_i
  rescue
    puts "Invalid track provided. Try again."
    retry
  end

  def extract(track_id)
    puts `mkvextract tracks "#{expanded_file}" #{track_id}:#{export_temp_file}`
    IO.read(export_temp_file, :encoding => 'UTF-8') \
      .tap {|_| File.delete(export_temp_file) }
  end

  def identify
    `mkvmerge -i "#{expanded_file}"`
  end

  def expanded_file
    file.expand_path
  end

  def identify_ass_regexp
    /Track ID (\d): subtitles \(S_TEXT\/ASS\)/
  end

  def export_temp_file
    "/tmp/smart_ass_export-#{Process.pid}"
  end
end
