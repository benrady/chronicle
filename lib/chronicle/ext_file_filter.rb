require 'java'
require 'java'

java_import javax.swing.filechooser.FileFilter

class ExtFileFilter < FileFilter
  def initialize(ext, desc)
    super()
    @ext = ext
    @desc = desc
  end

  def accept(f)
    f.to_s.downcase.end_with? @ext
  end

  def getDescription
    @desc
  end
end
