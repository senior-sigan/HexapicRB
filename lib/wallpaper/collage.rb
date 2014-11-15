require 'mini_magick'
require 'tempfile'
module Wallpaper
  class Collage
    attr_reader :height, :width

    def initialize(width = 1920, height = 1280)
      @height = height
      @width = width
    end

    def make(pictures)
      if pictures.size == 1
        Downloader.get pictures.first
      else
        imgs = pictures.map do |picture|
          picture = Downloader.get(picture) if picture.path.nil?
          picture.path
        end      
        file_path = Downloader.generate_file_path("#{rand(1000)}.jpg")

        MiniMagick::Tool::Montage.new do |m|
          m << '-mode'
          m << 'concatenate'
          m << '-tile'
          m << '3x2'
          imgs.each{|img| m << img}
          m << file_path
        end

        puts file_path
        Repository::Picture.new('','','', file_path)
      end
    end
  end
end