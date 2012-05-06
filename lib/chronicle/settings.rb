require "yaml"

class Settings < Hash
  SETTINGS_FILE = File.expand_path("~/.chronicle/settings.yaml")
  def initialize
    home = File.expand_path("~")
    merge!({
      :sheet_dir => home,
      :roster_dir => home,
      :output_dir => home
    })
    merge! YAML::load_file(SETTINGS_FILE) if File.exists? SETTINGS_FILE
  end

  def []=(key, value)
    super(key, value)
    File.open(SETTINGS_FILE, 'w') do |f| 
      YAML::dump(self, f)
    end
  end
end
