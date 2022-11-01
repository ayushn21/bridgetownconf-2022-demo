class Polaroid::Single < Bridgetown::Component
  def initialize(photo = nil)
    @photo = photo
  end

  def src
    return nil unless @photo.present?

    "/#{@photo.relative_file_path}"
  end
end