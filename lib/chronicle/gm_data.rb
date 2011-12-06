class GMData
  IO = javax.imageio.ImageIO

  def self.load_image(file)
    if not File.exists? file
      STDERR.puts "Could not find image file #{file}."
      nil
    else
      IO.read(java.io.File.new(file))
    end
  end

  def self.load(chronicle_sheet)
    load_image(chronicle_sheet)
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
      :gm_signature => signature_image
    }
  end
  
end
