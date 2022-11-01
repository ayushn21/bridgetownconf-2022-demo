class Builders::AlbumsBuilder < SiteBuilder
  def build
    hook :site, :post_read do |site|
      site.data.albums = build_albums(:albums)

      generate_pages(site.data.albums)
    end
  end

  private

    def build_albums(type = :albums)
      if albums = load_content_from_disk(type)
        return albums
      end

      albums = []

      dir_tree = Dir[site.in_root_dir("src", "photographs", type, "*")]
      dir_tree.each do |album_dir|
        albums << Album.new(album_dir, type.to_s.singularize.to_sym)
      end

      write_content_to_disk(albums, type)

      return albums
    end

    def generate_pages(albums)
      albums.each do |album|
        site.generated_pages << Pages::Album.new(site, album)

        album.photos.each_with_index do |photo, index|
          site.generated_pages << Pages::Photo.new(site, album, photo, index)
        end
      end
    end

    def content_path
      site.in_source_dir("_content")
    end

    def write_content_to_disk(content, file)
      File.open(File.join(content_path, "#{file}.yml"), "w") do |file|
        file.write YAML.dump(content)
      end
    end

    def load_content_from_disk(type)
      file_path = File.join(content_path, "#{type}.yml")

      if File.exist?(file_path)
        YAML.safe_load(
          File.read(file_path),
          permitted_classes: [Album, Photo, Symbol],
          aliases: true
        )
      else
        nil
      end
    end
end