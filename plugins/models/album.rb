class Album
  attr_reader :id, :name, :type, :cover, :photos

  def initialize(dir, type)
    @dir = dir
    @contents = Dir["#{dir}/*"]
    @id = dir.split("/").last
    @type = type

    load_info
    load_photos
  end

  def encode_with(coder)
    coder["name"] = @name
    coder["cover"] = @cover
    coder["photos"] = @photos
    coder["id"] = @id
    coder["dir"] = @dir
    coder["type"] = @type
  end

  private

    def load_info
      info_file_path = @contents.find { |paths| paths.end_with? "_info.yml" }
      info_file = File.read info_file_path
      info = YAML.load(info_file)

      @name = info["name"]

      @cover = Photo.new(File.join(@dir, info["cover"]), self)
    end

    def load_photos
      @photos = []

      photo_paths = @contents.filter { |paths| paths.end_with? ".jpg" }
      photo_paths.each do |path|
        @photos << Photo.new(path, self)
      end
    end
end