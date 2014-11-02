class GnomeWallpaperSetter
  def initialize    
  end
  
  def set(path)
    comand = "gsettings set org.gnome.desktop.background picture-uri file:///#{path}"
    system comand
  end
end