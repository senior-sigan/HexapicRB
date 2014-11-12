module Wallpaper
  class Downloader
    def self.get(picture)
      pictures_dir = File.join(Dir.home, 'Pictures', 'wallpaper')
      Dir.mkdir(pictures_dir) unless Dir.exists? pictures_dir

      file_path = File.join(pictures_dir, picture.filename)
      
      File.open(file_path, 'w') do |f|
        f.puts Net::HTTP.get_response(URI.parse(picture.url)).body
      end

      File.absolute_path(file_path)
    end
  end
end