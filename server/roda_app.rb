class RodaApp < Bridgetown::Rack::Roda
  plugin :bridgetown_ssr
  plugin :bridgetown_routes

  route do |r|
    r.bridgetown
  end
end
