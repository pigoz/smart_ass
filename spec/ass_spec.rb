require "spec_helper"

describe SmartAss::Ass do
  subject {
    @file = "path/to/file/movie.mkv"
    SmartAss::Ass.new(@file)
  }

  it "holds onto a file" do
    subject.file.should == Pathname.new(@file)
  end

  describe "#tracks" do
    [
      {:f => 'info_1_t_3',     :e => [3],       :t => 'with 1 element'},
      {:f => 'info_3_t_3_5_6', :e => [3, 5, 6], :t => 'with many elements'},
      {:f => 'info_0',         :e => [],        :t => 'with 0 elements'},
    ].each do |test|
      it "returns an array of ASS track IDs (#{test[:t]})" do
        mock(subject).identify {
          IO.read(
            File.join(File.dirname(__FILE__), 'fixtures', test[:f]))
        }
        subject.tracks.should == test[:e]
      end # it #tracks
    end # do
  end # describe

end
