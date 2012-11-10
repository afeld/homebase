Telapi.config do |config|
  config.account_sid = ENV['HOMEBASE_TELAPI_SID'] || raise("Please set TelAPI SID") 
  config.auth_token  = ENV['HOMEBASE_TELAPI_TOKEN'] || raise("Please set TelAPI Token")
end