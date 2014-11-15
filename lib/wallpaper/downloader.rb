require 'fileutils'

module Wallpaper
  class Downloader
    def self.get(picture)
      file_path = self.generate_file_path(picture.filename)
      
      puts "Downloading #{picture.url}"
      File.open(file_path, 'w') do |f|
        f.puts Net::HTTP.get_response(URI.parse(picture.url)).body
      end

      res = picture.clone
      res.path = File.absolute_path(file_path)
      res
    end

    def self.generate_file_path(filename = nil)
      filename ||= (0...8).map { (65 + rand(26)).chr }.join + '.jpg'
      pictures_dir = File.join(Dir.home, 'Pictures', 'wallpaper')
      FileUtils.mkdir_p(pictures_dir) unless Dir.exists? pictures_dir

      File.join(pictures_dir, filename)
    end
  end
end