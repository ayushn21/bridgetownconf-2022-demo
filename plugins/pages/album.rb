class Pages::Album < Bridgetown::GeneratedPage
  def initialize(site, album)
    super(
      site,
      site.source,         # base path
      "/",                 # page location
      "#{album.id}.erb",   # page filename
      from_plugin: true
    )

    self.data.layout = "default"
    self.data.album = album
    self.data.title = album.name

    self.content = File.read(
      site.in_source_dir("_prototypes", "album.erb")
    )
  end
end
