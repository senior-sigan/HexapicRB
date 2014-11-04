require_relative "wallpaper/version"
require_relative "wallpaper/mate_wallpaper_setter"
require_relative "wallpaper/repository"
require_relative "wallpaper/downloader"
require_relative "wallpaper/desktop_environment"

module Wallpaper
  def self.start
    setter = nil
    case DesktopEnvironment.which
    when :mate
      setter = MateWallpaperSetter.new
    when :gnome3
      setter = GnomeWallpaperSetter.new
    when :xfce4
      setter = XfceWallpaperSetter.new
    end
  
    repository = Repository::FlickrRepository.new
    picture = repository.find_picture
    picture.path = Downloader.get picture

    setter.set picture.path
  end
end

Wallpaper.start
