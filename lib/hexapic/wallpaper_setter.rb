module Hexapic
  module WallpaperSetter
    class XFCE4
      def set(path)
        out = DesktopEnvironment.output
        command = "xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor#{out}/workspace0/last-image -s #{path}"
        command = "xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor#{out}/workspace1/last-image -s #{path}"
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

    SETTER = {
      mate: Mate, 
      gnome3: Gnome3, 
      xfce4: XFCE4, 
      kde4: KDE4, 
      gala: Gnome3
    }

    def self.build
      de = DesktopEnvironment.which
      klass = SETTER[de]
      if klass.nil?
        raise "Unsupported DE #{de}. Please ask maitainer about it."
      else
        klass.new
      end
    end
  end
end