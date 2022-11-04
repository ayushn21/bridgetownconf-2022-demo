class Routes::Buy < Bridgetown::Rack::Routes
  route do |r|
    r.post "buy" do
      r.redirect r.referer unless params[:card].present?

      url = Aws::S3::Presigner.new.presigned_url(
        :get_object,
        bucket: "bridgetownconf2022-demo",
        key: params[:photo]
      )

      r.redirect url
    end
  end
end