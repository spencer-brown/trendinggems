require 'rubygems'
require 'gems'

gem_hash = Gems.info 'rails'

# set github address
homepage = gem_hash["homepage_uri"]

if homepage.split('.')[1] == 'github'
	github = homepage
else
	github = gem_hash["source_code_uri"]
end
puts github

# set number of downloads
downloads = gem_hash["downloads"]
puts downloads