class Builders::Helpers < SiteBuilder
  def build
    helper "api" do |path|
      "#{ENV['API_URL']}/#{path}"
    end
  end
end