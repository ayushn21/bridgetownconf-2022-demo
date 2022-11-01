class Photo
  attr_reader :filename, :camera, :lens, :taken_on,
              :shutter_speed, :aperture, :iso, :focal_length

  def initialize(path, album)
    @path = path
    @album = album
    @filename = path.split("/").last

    extract_exif_data
  end

  def relative_file_path
    "albums/#{@album.id}/#{filename}"
  end

  def relative_path
    "#{@album.id}/#{filename}"
  end

  def encode_with(coder)
    coder["album"] = @album
    coder["filename"] = @filename
    coder["camera"] = @camera
    coder["lens"] = @lens
    coder["taken_on"] = @taken_on
    coder["shutter_speed"] = @shutter_speed
    coder["aperture"] = @aperture
    coder["iso"] = @iso
    coder["focal_length"] = @focal_length
  end

  private
    def extract_exif_data
      exif_data = EXIFR::JPEG.new(@path)

      @camera = exif_data.model.titleize
      @lens = exif_data.lens_model
      @taken_on = user_facing_date(exif_data.date_time_original)
      @shutter_speed = exif_data.exposure_time.to_s
      @aperture = "f/#{exif_data.f_number.to_f}"
      @iso = exif_data.iso_speed_ratings
      @focal_length = "#{exif_data.focal_length.to_i} mm"
    end

    def user_facing_date(time)
      day = time.day.ordinalize
      time.strftime("#{day} %B, %Y")
    end
end
