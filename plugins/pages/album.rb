class Pages::Album < Bridgetown::GeneratedPage
  def initialize(site, album)
    super(site, site.source, "/", "#{album.id}.erb", from_plugin: true)

    self.content = File.read(site.in_source_dir("_prototypes", "album.erb"))
    self.data.layout = "default"
    self.data.album = album
    self.data.title = album.name
  end
end
