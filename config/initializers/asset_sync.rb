AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = 'AKIAJ6VMTPKJOGWKTHAA'
  config.aws_secret_access_key = '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'
  
  if Rails.env == "production"
    config.fog_directory = 'tracely-assets'
  else
    config.fog_directory = 'tracely-dev-assets'
  end
  
  
  # Increase upload performance by configuring your region
  # config.fog_region = 'eu-west-1'
  #
  # Don't delete files from the store
  config.existing_remote_files = "delete"
  #
  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to 
  # upload instead of searching the assets directory.
  config.manifest = true
  #
  # Fail silently.  Useful for environments such as Heroku
  config.fail_silently = true
end