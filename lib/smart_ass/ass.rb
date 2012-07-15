require 'pathname'

class SmartAss::Ass
  attr_reader :file

  def initialize(file)
    @file = Pathname.new(file)
  end

  def tracks
    identify.each_line \
      .map    {|l| (l =~ identify_ass_regexp) ? $1 : nil } \
      .compact \
      .map    &:to_i
  end

  # TODO: test this!
  def extract(track_id)
    `mkvextract tracks #{expanded_file} #{track_id}:#{export_temp_file}`
    IO.read(export_temp_file).tap {|_| File.delete(export_temp_file) }
  end

  private
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
