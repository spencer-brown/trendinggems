require 'open-uri'
require 'json'
require 'net/http'
require 'nokogiri'

# START_LETTER = 65
# GEMS_PER_PAGE = 30.0
# LETTERS_IN_ALPHA = 26

# LETTERS_IN_ALPHA.times do |i|
# 	letter = (START_LETTER + i).chr
# 	STDERR.write "starting letter #{letter}...\n"

# 	first_page = Nokogiri::HTML(open("http://rubygems.org/gems?letter=#{letter}&page=1"))
# 	total_number_gems = first_page.xpath("/html/body/div/div[3]/div/p/b[2]").text.to_f
# 	number_of_pages = (total_number_gems/GEMS_PER_PAGE).ceil

# 	for page in 1..number_of_pages
# 		STDERR.write "#{page}\n"
# 		for i in 1..GEMS_PER_PAGE
# 			STDERR.write "#{i}\n"
# 		end
# 	end
# end


puts "starting letter"
first_page = Nokogiri::HTML(open("http://rubygems.org/gems?letter=A&page=1"))
puts "Hello World"