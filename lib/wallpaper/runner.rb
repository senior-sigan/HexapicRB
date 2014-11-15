module Wallpaper
  class Runner
    def initialize(tags)
      @tags = tags.to_s
    end
    
    def run
      collage = Collage.new
      setter = WallpaperSetter.build  
      repository = Repository::InstagramRepository.new
      pictures = repository.find_pictures(@tags)
      picture = collage.make(pictures)

      setter.set picture.path
    end
  end
end