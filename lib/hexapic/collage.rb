module Hexapic
  class Collage
    attr_reader :height, :width

    def make(pictures)
      puts 'Start collage'
      if pictures.size == 1
        Downloader.get pictures.first
      else
        images = []
        file_path = Downloader.generate_file_path
        pictures.map.with_index do |picture,index|
          Thread.new(index) do |i| 
            picture = Downloader.get(picture) if picture.path.nil?
            images[i] = picture.path
          end
        end.each{ |thr| thr.join }              

        puts "Make collage and save to #{file_path}"
        MiniMagick::Tool::Montage.new do |m|
          m << '-mode'
          m << 'concatenate'
          m << '-tile'
          m << '3x2'
          images.each{|img| m << img}
          m << file_path
        end

        puts file_path
        Repository::Picture.new('','','', file_path)
      end
    end
  end
end