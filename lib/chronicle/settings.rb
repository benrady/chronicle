require "yaml"

module Chronicle
  class Settings < Hash
    SETTINGS_FILE = File.expand_path("~/.chronicle/settings.yaml")
    def initialize
      if File.exists? SETTINGS_FILE
        merge! YAML::load_file(SETTINGS_FILE) 
      else
        merge!({
          :sheet_dir => File.expand_path("~")
        })
      end
    end

    def []=(key, value)
      super(key, value)
      File.open(SETTINGS_FILE, 'w') do |f| 
        YAML::dump(self, f)
      end
    end
  end
end
