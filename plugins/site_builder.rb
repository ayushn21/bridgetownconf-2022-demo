require 'exifr/jpeg'
require 'yaml'
require 'active_support/core_ext/integer/inflections'
require 'aws-sdk-s3'

if Bridgetown.env.development?
  require 'dotenv'
  Dotenv.load
end

class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end