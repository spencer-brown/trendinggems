require 'github_api'
require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

end_of_db = false

# repos = Github::Repos.new user: 'twbs'
# bootstrap = repos.get :repo => 'bootstrap'
# puts bootstrap["stargazers_count"]


# first 1000 --> sets first gt_value
gems = Parse::Query.new("Gem3").tap do |q|
	q.limit = 1000
	q.order_by = "objectId"
end.get

# for item in gems
# 	puts item["objectId"]
# end

gt_value = gems.last["objectId"]

# this number*1000 (plus the first thousand) can exceed the total # of rows without causing an error
# but only if by < 1000
# ex: (1000 + 44*1000) - 44600 < 1000, no error. (1000 + 45*1000) - 44600 > 1000, error.
while !end_of_db do
	# can't skip more than 10,000 which is a problem because we have 44.6k rows
	# --> Stack Overflow fix: order by objectId and then query greater than the last objectId
	gems = Parse::Query.new("Gem3").tap do |q|
		q.limit = 1000
		q.order_by = "objectId"
		q.greater_than('objectId', gt_value)
	end.get

	for item in gems
		puts item["objectId"]
	end

	gt_value = gems.last["objectId"]

	if gems.length() < 1000
		end_of_db = true
	end
end