Geocoder.configure do |config|
  # geocoding service:
  config.lookup = :bing

  # to use an API key:
  config.api_key = ENV['HOMEBASE_BING_KEY'] || raise("please set HOMEBASE_BING_KEY")
end
