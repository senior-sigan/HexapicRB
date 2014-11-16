module Hexapic
  class DesktopEnvironment
    DE = {
      'Metacity (Marco)'=> :mate, 
      'Xfwm4'=> :xfce4, 
      'Gnome3'=> :gnome3, 
      'Mutter (Muffin)'=> :cinnamon, 
      'Gala' => :gala
    }
    
    def self.which
      wm_name = nil

      Open3.popen3('xprop', '-root', '_NET_SUPPORTING_WM_CHECK') do |inp, out, err|
        inp.close
        err.close
        winpdow_id = out.gets.split('#').last.strip
        out.close
        Open3.popen3('xprop', '-id', winpdow_id, '8s', '_NET_WM_NAME') do |inp, out, err|
          inp.close
          err.close
          wm_name = out.gets.split('=').last.strip.gsub('"','')
        end
      end
      
      DE[wm_name] || wm_name.to_sym
    end    
    def self.output
      output_name = nil

      Open3.popen3('xrandr' ,'| grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/"') do |inp, out, err|
        inp.close
        err.close
        output_name = out.strip
        out.close
      end

      output_name
    end
  end
end