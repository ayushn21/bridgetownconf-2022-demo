class Pages::Photo < Bridgetown::GeneratedPage
  def initialize(site, album, photo)
    super(
      site,
      site.source,
      "/#{album.id}",
      "#{photo.filename.split('.').first}.erb",
      from_plugin: true
    )

    self.content = File.read(site.in_source_dir("_prototypes", "photo.erb"))
    self.data.layout = "default"
    self.data.photo = photo
    self.data.album = album.id
    self.data.title = album.name
  end
end
