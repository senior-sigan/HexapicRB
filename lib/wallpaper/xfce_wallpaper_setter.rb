class XfceWallpaperSetter
  def initialize    
  end
  
  def set(path)
    command = "xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace1/last-image -s #{path}"
    system command
  end  
end