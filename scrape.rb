require 'open-uri'
require 'json'
require 'net/http'
require 'nokogiri'

START_LETTER = 65
GEMS_PER_PAGE = 30.0
LETTERS_IN_ALPHA = 26

LETTERS_IN_ALPHA.times do |i|
	letter = (START_LETTER + i).chr
	STDERR.write "starting letter #{letter}\n"

	first_page = Nokogiri::HTML(open("http://rubygems.org/gems?letter=#{letter}&page=1"))
	total_number_gems = first_page.xpath("/html/body/div/div[3]/div/p/b[2]").text.to_f
	number_of_pages = (total_number_gems/GEMS_PER_PAGE).ceil

	for page in 1..number_of_pages
		doc = Nokogiri::HTML(open("http://rubygems.org/gems?letter=#{letter}&page=#{page}"))
		for i in 1..GEMS_PER_PAGE
			gem_name = doc.xpath("/html/body/div/div[3]/div/div[3]/ol/li[#{i}]/a/strong").text.split(' ')[0]
			puts gem_name if gem_name
		end
	end
end