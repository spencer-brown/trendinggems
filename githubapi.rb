require 'net/http'
require 'github_api'
require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

# repos = Github::Repos.new user: 'twbs'
# bootstrap = repos.get :repo => 'bootstrap'
# puts bootstrap["stargazers_count"]


# first pass
gems = Parse::Query.new("Gem3").tap do |q|
	q.limit = 2
	q.order_by = "objectId"
end.get

for item in gems
	puts item["objectId"]
end

gt_value = gems.last["objectId"]

4.times do |i|
	# can't skip more than 10,000 which is a problem because we have 44.6k rows
	# --> Stack Overflow fix: order by objectId and then query greater than the last objectId
	gems = Parse::Query.new("Gem3").tap do |q|
		q.limit = 2
		q.order_by = "objectId"
		q.greater_than('objectId', gt_value)
	end.get

	for item in gems
		puts item["objectId"]
	end

	gt_value = gems.last["objectId"]
end

gems = Parse::Query.new("Gem3").tap do |q|
	q.limit = 10
	q.order_by = "objectId"
end.get

for item in gems
	puts item["objectId"]
end