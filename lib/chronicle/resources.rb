require 'java'

module Resources
  IO = javax.imageio.ImageIO

  def self.core_class
    Java::JarMain.java_class
  end

  def self.load_resource(name)
    if File.exists? name
      return java.io.FileInputStream.new(name)
    end
    core_class.resource_as_stream("/#{name}")
  end

  def self.list_resources(dir="")
    if running_in_jar?
      jar = core_class.protection_domain.code_source.location
      stream = java.util.zip.ZipInputStream.new(jar.openStream)
      resources = []
      while entry = stream.next_entry
        resources << entry.name
      end
      resources
    else
      Dir.glob("resources/sheets/**")
    end
  end

  def self.load_image_resource(name)
    IO.read(load_resource(name))
  end

  def self.load_image(file)
    if not File.exists? file
      STDERR.puts "Could not find image file #{file}"
      nil
    else
      IO.read(java.io.File.new(file))
    end
  end

  def self.load_gm_data
    initial_image = load_image("#{ENV['HOME']}/.chronicle/initials.png")
    signature_image = load_image("#{ENV['HOME']}/.chronicle/signature.png")
    {
      :date => Time.new.strftime("%D"),
      :xp_gained_initial => initial_image,
      :prestige_gained_initial => initial_image,
      :gold_gained_initial => initial_image,
      :day_job_initial => initial_image,
      :gm_signature => signature_image,
      :gold_spent => 0
    }
  end

  def self.running_in_jar?
    begin
      java.lang.class.Class::forName("JarMain")
      return true
    rescue
      return false
    end
  end
  
end
