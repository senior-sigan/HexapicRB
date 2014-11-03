require_relative "wallpaper/version"
require_relative "wallpaper/mate_wallpaper_setter"
require_relative "wallpaper/repository"
require_relative "wallpaper/downloader"

module Wallpaper
  def self.start
    setter = MateWallpaperSetter.new
    repository = Repository::FlickrRepository.new
    picture = repository.find_picture
    picture.path = Downloader.get picture

    setter.set picture.path
  end
end

Wallpaper.start
