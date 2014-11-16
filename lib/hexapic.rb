$LOAD_PATH.unshift File.expand_path('.')

require 'faraday'
require 'json'
require 'uri'
require 'open3'
require 'mini_magick'
require 'tempfile'
require 'fileutils'
require 'flickr'

require 'hexapic/version'
require 'hexapic/desktop_environment.rb'
require 'hexapic/wallpaper_setter'
require 'hexapic/api'
require 'hexapic/repository'
require 'hexapic/downloader'
require 'hexapic/collage'

require 'hexapic/runner'