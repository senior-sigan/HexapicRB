module Hexapic
  module Repository
    COUNT = 6

    class TestRepository
      def initialize
        puts 'Using Local Dir'
      end

      def find_pictures(tag)
        path = "/home/ilya/Pictures/wallpaper/10810006_1487374498191383_1977583548_n.jpg"
        (1..COUNT).map { Picture.new(path, path, path, path) }
      end
    end

    class InstagramRepository
      CLIENT_ID = '417c3ee8c9544530b83aa1c24de2abb3'

      def initialize
        @instagram = API::Instagram.new(CLIENT_ID)
        puts 'Using Instagram'
      end

      def find_pictures(tag)
        tag.delete(',')
        puts "Getting last images by tag #{tag}"
        pics = @instagram.search(tag).sample(COUNT).map do |r|
          Picture.new(r[:url], r[:link], r[:id])
        end

        raise ImagesNotFound.new("Found only #{pics.size} images. Need #{COUNT}.") if pics.size < COUNT 
        pics
      end
    end

    class FlickrRepository
      API_KEY = 'bd053065ce6662cb4b2f4c0be2b65266'
      
      def initialize
        @flickr = Flickr.new(api_key: API_KEY, verify_ssl: false)
        puts 'Using Flickr'
      end
      
      def find_pictures(tags)
        options = {}
        options[:tag_mode] = 'and'
        options[:tags] = tags
        options[:sort] = 'relevance'
        options[:content_type] = '1'
        options[:extras] = 'url_q,url_sq,url_s'
        puts "Getting last images by tags #{tags}"
        pics = @flickr.search(options).sample(COUNT).map do |photo|
          Picture.new(photo.source('Large Square'), photo.url, photo.filename)
        end

        raise ImagesNotFound.new("Found only #{pics.size} images. Need #{COUNT}.") if pics.size < COUNT 
        pics
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

    class ImagesNotFound < StandardError; end
    class NoInternet < StandardError; end
    LIST = {flickr: FlickrRepository, instagram: InstagramRepository}
  end
end