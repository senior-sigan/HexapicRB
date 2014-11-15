require 'flickr'
require 'instagram'
module Wallpaper
  module Repository
    class TestRepository
      def find_pictures(tag)
        path = "/home/ilya/Pictures/wallpaper/10810006_1487374498191383_1977583548_n.jpg"
        (1..6).map { Picture.new(path, path, path, path) }
      end
    end

    class InstagramRepository
      CLIENT_ID = '417c3ee8c9544530b83aa1c24de2abb3'
      COUNT = 6

      def initialize
        @instagram = Instagram.client(client_id: CLIENT_ID)
      end

      def find_pictures(tag)
        puts "Getting last images by tag #{tag}"
        pics = @instagram.tag_recent_media(tag, {count: 100}).sort{|a,b| b.likes[:count] <=> a.likes[:count]}.take(COUNT).map do |r|
          url = r.images.standard_resolution.url
          Picture.new(url, url, url.split('/').last)
        end

        raise ImagesNotFound.new("Found only #{pics.size} images. Need #{COUNT}.") if pics.size < COUNT 
        pics
      rescue Exception => e
        raise NoInternet.new(e.message)
      end
    end

    class FlickrRepository
      API_KEY = 'bd053065ce6662cb4b2f4c0be2b65266'
      
      def initialize
        @flickr = Flickr.new(api_key: API_KEY, verify_ssl: false)
      end
      
      def find_pictures(tags)
        options = {}
        options[:tag_mode] = 'and'
        options[:tags] = tags
        options[:sort] = 'relevance'
        options[:content_type] = '1'
        options[:extras] = 'url_o,url_l'
        photos = @flickr.search(options)
        photo = photos.sample
        puts photo.url

        [Picture.new(photo.source('Large'), photo.url, photo.filename)]
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
  end
end