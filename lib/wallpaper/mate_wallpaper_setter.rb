class MateWallpaperSetter
  def initialize    
  end
  
  def set(path)
    comand = "gsettings set org.mate.background picture-filename #{path}"
    puts comand
    system comand
  end
end