require 'flickr'

module Repository
  class FlickrRepository
    API_KEY = 'bd053065ce6662cb4b2f4c0be2b65266'
    
    def initialize
      @flickr = Flickr.new(api_key: API_KEY, verify_ssl: false)
    end
    
    def find_picture
      options = {}
      options[:tag_mode] = 'and'
      options[:tags] = 'nature,sunset'
      options[:sort] = 'relevance'
      options[:content_type] = '1'
      options[:extras] = 'url_o,url_l'
      photos = @flickr.search(options)
      photo = photos.sample
      puts photo.url

      Picture.new(photo.source('Large'), photo.url, photo.filename)
    end
  end

  class Picture
    attr_accessor :url, :post_url, :filename, :path

    def initialize(url, post_url, filename, path = nil)
      @url = url
      @post_url = post_url
      @filename = filename
      @path = path
    end
  end
end