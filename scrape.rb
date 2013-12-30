require 'open-uri'
require 'json'
require 'net/http'
require 'nokogiri'
require 'rubygems'
require 'gems'
require 'parse-ruby-client'

def is_github str
	str.split('.')[1] == 'github' || str.split('.')[0] == 'http://github' || str.split('.')[0] == 'https://github'
end

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

START_LETTER = 65
GEMS_PER_PAGE = 30.0
LETTERS_IN_ALPHA = 26

LETTERS_IN_ALPHA.times do |i|
	letter = (START_LETTER + i).chr
	# puts "starting letter"

	first_page = Nokogiri::HTML(open("http://rubygems.org/gems?letter=A&page=1"))
	total_number_gems = first_page.xpath("/html/body/div/div[3]/div/p/b[2]").text.to_f
	number_of_pages = (total_number_gems/GEMS_PER_PAGE).ceil
	# puts "Hello World"
	for page in 1..number_of_pages
		STDERR.write "Scraping page #{page} for letter #{letter}\n"
		doc = Nokogiri::HTML(open("http://rubygems.org/gems?letter=#{letter}&page=#{page}"))
		for i in 1..GEMS_PER_PAGE
			gem_name = doc.xpath("/html/body/div/div[3]/div/div[3]/ol/li[#{i}]/a/strong").text.split(' ')[0]

			# prevent blank lines
			next unless gem_name

			# retrieve gem info
			gem_hash = Gems.info gem_name

			# set homepage and source_code addresses
			homepage = gem_hash["homepage_uri"]
			# puts "gem_hash homepage:"
			# puts homepage
			source_code = gem_hash["source_code_uri"]
			# puts "gem_hash source_code:"
			# puts source_code

			# verify that homepage is a github. if not, try source code page. otherwise, skip to next
			if homepage
				github = homepage if is_github homepage
				# puts "homepage github:"
				# puts github
			end

			if source_code
				github = source_code if is_github source_code
				# puts "source_code github:"
				# puts github
			end

			if github.nil?
				next
			end

			# set number of downloads
			downloads = gem_hash["downloads"]

			# create new entry in sqlite for gem
			# Blah.create(:name => gem_name,
			# 			    	:github => github,
			# 			    	:downloads => downloads)

			blah = Parse::Object.new("Gem")
			blah["Name"] = gem_name
			blah["Downloads"] = downloads
			blah["Github"] = github
			blah.save

			github = nil
		end
	end
end