class GMData
  IO = javax.imageio.ImageIO

  def self.load_image(file)
    IO.read(java.io.File.new(file))
  end

  def self.load_chronicle_sheet
    load_image('chronicle_sheet.png')
  end

  def self.load_gm_data
    initial_image = load_image('/Users/brady/.chronicle/initials.png')
    signature_image = load_image('/Users/brady/.chronicle/signature.png')
    {
      #FIXME
      :gm_society_number => '38803',
      :date => Time.new.strftime("%D"),
      :xp_gained_initial => initial_image,
      :prestige_gained_initial => initial_image,
      :gold_gained_initial => initial_image,
      :day_job_initial => initial_image,
      :gm_signature => signature_image
    }
  end
  
end
