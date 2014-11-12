require_relative "desktop_environment"
module Wallpaper
  module WallpaperSetter
    class XFCE4
      def set(path)
        command = "xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace1/last-image -s #{path}"
        system command
      end  
    end  

    class Gnome3
      def set(path)
        comand = "gsettings set org.gnome.desktop.background picture-uri file:///#{path}"
        system comand
      end
    end

    class Mate
      def set(path)
        comand = "gsettings set org.mate.background picture-filename #{path}"
        system comand
      end
    end

    class KDE4
      def set(path)
        comand = "dbus-send --session --dest=org.new_wallpaper.Plasmoid --type=method_call /org/new_wallpaper/Plasmoid/0 org.new_wallpaper.Plasmoid.SetWallpaper string:#{path}"
        system comand
      end
    end

    DE = {mate: Mate, gnome3: Gnome3, xfce4: XFCE4, kde4: KDE4}

    def self.build
      klass = DE[DesktopEnvironment.which]
      klass.new unless klass.nil?
    end
  end
end