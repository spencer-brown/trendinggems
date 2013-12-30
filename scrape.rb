require 'open-uri'
# require 'json'
# require 'net/http'
require 'nokogiri'
require 'rubygems'
require 'gems'
require 'sqlite3'
# require 'active_record'
 
# ActiveRecord::Base.establish_connection(
#     :adapter => "sqlite3",
#     :database  => "gems.db"
# )
 
# ActiveRecord::Schema.define do
#     create_table :blahs do |table|
#         table.column :name, :string
#         table.column :downloads, :integer
#         table.column :github, :string
#     end
# end

# class Blah < ActiveRecord::Base
# end

# START_LETTER = 65
# GEMS_PER_PAGE = 30.0
# LETTERS_IN_ALPHA = 26

# LETTERS_IN_ALPHA.times do |i|
	# letter = (START_LETTER + 0).chr
	puts "starting letter"

	first_page = Nokogiri::HTML(open("http://rubygems.org/gems?letter=A&page=1"))
	# total_number_gems = first_page.xpath("/html/body/div/div[3]/div/p/b[2]").text.to_f
	# number_of_pages = (total_number_gems/GEMS_PER_PAGE).ceil
	puts "Hello World"
	# for page in 1..number_of_pages
	# 	# STDERR.write "Scraping page #{page} for letter #{letter}\n"
	# 	doc = Nokogiri::HTML(open("http://rubygems.org/gems?letter=#{letter}&page=#{page}"))
	# 	for i in 1..GEMS_PER_PAGE
	# 		gem_name = doc.xpath("/html/body/div/div[3]/div/div[3]/ol/li[#{i}]/a/strong").text.split(' ')[0]
	# 		puts gem_name
	# 		# prevent blank lines
	# 		# next unless gem_name

	# 		# retrieve gem info
	# 		# gem_hash = Gems.info gem_name

	# 		# set homepage and source_code addresses
	# 		# homepage = gem_hash["homepage_uri"]
	# 		# soure_code = gem_hash["source_code_uri"]

	# 		# verify that homepage is a github. if not, try source code page. otherwise, skip to next
	# 		# if homepage.split('.')[1] == 'github'
	# 		# 	github = homepage
	# 		# elsif soure_code.split('.')[1] == 'github'
	# 		# 	github = soure_code
	# 		# else
	# 		# 	next
	# 		# end

	# 		# set number of downloads
	# 		# downloads = gem_hash["downloads"]

	# 		# # create new entry in database for gem
	# 		# Blah.create(:name => gem_name,
	# 		# 			    	:github => github,
	# 		# 			    	:downloads => downloads)

	# 		# STDERR.write github
	# 	end
	# end
# end