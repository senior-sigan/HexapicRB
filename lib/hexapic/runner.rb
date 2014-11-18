module Hexapic
  class Runner   
    def run(repository = :instagram, query, type)
      collage = Collage.new
      setter = WallpaperSetter.build  
      repository = Repository::LIST[repository].new
      picture = nil
      case type
      when :tags
        pictures = repository.find_pictures(query)
      when :username
        pictures = repository.find_pictures_by_username(query)              
      end
      
      picture = collage.make(pictures)

      setter.set picture.path
    end
  end
end