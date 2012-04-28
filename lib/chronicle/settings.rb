require "yaml"

module Chronicle
  class Settings < Hash
    SETTINGS_FILE = File.join(Dir::home, ".chronicle/settings.yaml")
    def initialize
      # FIXME load settings from disk here
      merge! YAML::load( File.open(SETTINGS_FILE, 'a+')) if File.exists? SETTINGS_FILE
    end

    def []=(key, value)
      super(key, value)
      File.open(SETTINGS_FILE, 'a+') do |f| 
        f.puts YAML::dump(self)
      end
    end
  end
end
