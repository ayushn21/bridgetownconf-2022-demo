class Builders::AlbumsBuilder < SiteBuilder
  def build
    hook :site, :post_read do |site|
      build_albums
      generate_album_pages
    end
  end

  private

    def build_albums
      site.data.albums = []

      dir_tree = Dir[site.in_root_dir("src", "albums", "*")]
      dir_tree.each do |album_dir|
        site.data.albums << Album.new(album_dir)
      end
    end

    def generate_album_pages
      site.data.albums.each do |album|
        site.generated_pages << Pages::Album.new(site, album)

        album.photos.each do |photo|
          site.generated_pages << Pages::Photo.new(site, album, photo)
        end
      end
    end
end