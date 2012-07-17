# SmartAss

Utility for Y'CbCr ColorMatrix conversion of ASS Subtitles

If you are smart and know about ASS subtitles you are probably wondering
what Y'CbCr has to do with ASS. As a matter of fact ASS uses RGB hex for
color representation.

The problem is some subtitles renderers (VSFilter) on Windows decided it was
too stupid to render the RGB directly (don't even ask about it). So they
started doing a `R'G'B' ->(BT.601) Y'CbCr ->(BT.601) R'G'B'` chain of
conversions.

The problem is some fansubbers started to actually author content for
these broken renderers and the result is you get broken colors on
subtitles in the video players that are actually getting it right.

This tool is an attempt to fix this problem. Using mkvextract/mkvmerge
and some matrix multiplications it generates a new ass file where the
colors passed through the following conversions:

    R'G'B' ->(BT.601) Y'CbCr ->(BT.709) R'G'B'

## Installation

Make sure you have mkvtoolnix (mkvmerge and mkvextract) utilities
installed and in your path. For example, on OSX and homebrew it's as simple as:

    brew install mkvtoolnix

Install the Ruby Gem:

    [sudo] gem smart_ass

## Usage

This is really minimal. No options for now.

    smart_ass path/to/movie.mkv

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contacts

Look for pigoz on irc.freenode.net.
