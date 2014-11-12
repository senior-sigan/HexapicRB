module Wallpaper
  class Runner
    def initialize(tags)
      @tags = tags.to_s
    end
    
    def run
      setter = WallpaperSetter.build  
      repository = Repository::FlickrRepository.new
      picture = repository.find_picture(@tags)
      picture.path = Downloader.get picture

      setter.set picture.path
    end
  end
end