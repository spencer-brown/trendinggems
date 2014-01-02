require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

end_of_db = false
indicator = 1

# first 1000 --> sets first gt_value
gems = Parse::Query.new("Gem3").tap do |q|
	q.limit = 1000
	q.order_by = "objectId"
end.get

for item in gems
	puts indicator
	url = item["Github"]
	first_split = url.split('.')

	if first_split.length() == 2
		# http://github.com/user/repo

		# ['com', 'user', 'repo']
		second_split = first_split[1].split('/')

		if second_split.length() < 3
			# delete db entry --> https://github.com/eros4, not real
			puts "Should delete this entry"
		else
			user = second_split[1]
			repo = second_split[2]
			length = '2'
		end
	elsif first_split.length() == 3
		# www.github.com/user/repo or user.github.com/repo

		if first_split[0] == 'http://www' || first_split[0] == 'https://www' || first_split[0] == 'www'
			# com/user/repo
			second_split = first_split[2].split('/')
			
			user = second_split[1]
			repo = second_split[2]
			length = '3'

		else
			# user works with or without http(s)://
			user = first_split[0].split('//').last
			repo = (first_split[2].split('/'))[1]
		end
	elsif first_split.length() == 4
		# www.user.github.com/repo

		user = first_split[1]
		repo = first_split[3]
		length = '4'

	end

	# set github user and repo values
	# item["User"] = user
	# item["Repo"] = repo
	# puts 'User: '
	# puts user
	# puts 'Repo: '
	# puts repo
	# puts length
end

gt_value = gems.last["objectId"]



# iterate through the rest of the db
while !end_of_db do
	gems = Parse::Query.new("Gem3").tap do |q|
		q.limit = 1000
		q.order_by = "objectId"
		q.greater_than('objectId', gt_value)
	end.get

	for item in gems
		indicator = indicator + 1
		puts indicator
		url = item["Github"]
		first_split = url.split('.')

		if first_split.length() == 2
			# http://github.com/user/repo

			# ['com', 'user', 'repo']
			second_split = first_split[1].split('/')

			if second_split.length() < 3
				# delete db entry --> https://github.com/eros4, not real
				puts "Should delete this entry"
			else
				user = second_split[1]
				repo = second_split[2]
				length = '2'
			end
		elsif first_split.length() == 3
			# www.github.com/user/repo or user.github.com/repo

			if first_split[0] == 'http://www' || first_split[0] == 'https://www' || first_split[0] == 'www'
				# com/user/repo
				second_split = first_split[2].split('/')
				
				user = second_split[1]
				repo = second_split[2]
				length = '3'

			else
				# user works with or without http(s)://
				user = first_split[0].split('//').last
				repo = (first_split[2].split('/'))[1]
			end
		elsif first_split.length() == 4
			# www.user.github.com/repo

			user = first_split[1]
			repo = first_split[3]
			length = '4'

		end

		# set github user and repo values
		# item["User"] = user
		# item["Repo"] = repo
		# puts 'User: '
		# puts user
		# puts 'Repo: '
		# puts repo
		# puts length
	end

	gt_value = gems.last["objectId"]

	if gems.length() < 1000
		end_of_db = true
	end
end