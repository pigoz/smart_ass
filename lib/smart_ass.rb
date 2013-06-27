require "smart_ass/version"

module SmartAss
  autoload :App,              'smart_ass/app'
  autoload :MKV,              'smart_ass/mkv'
  autoload :InputFile,        'smart_ass/input_file'
  autoload :BT601ColorMatrix, 'smart_ass/bt601_colormatrix'
  autoload :BT709ColorMatrix, 'smart_ass/bt709_colormatrix'
  autoload :RGBAColor,        'smart_ass/rgba_color'
  autoload :YCbCrColorMatrix, 'smart_ass/ycbcr_colormatrix'
  autoload :YCbCrConverter,   'smart_ass/ycbcr_converter'
end
