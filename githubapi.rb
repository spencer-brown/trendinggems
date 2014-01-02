require 'net/http'
require 'github_api'
require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

TEST_COUNT = 10

# repos = Github::Repos.new user: 'twbs'
# bootstrap = repos.get :repo => 'bootstrap'
# puts bootstrap["stargazers_count"]

gems = Parse::Query.new("Gem3").tap do |q|
	q.limit = 5
	q.skip = 5
end.get

for item in gems
	puts item["Github"]
end

# result = query.get