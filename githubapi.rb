require 'net/http'
require 'github_api'

repos = Github::Repos.new user: 'twbs'

bootstrap = repos.get :repo => 'bootstrap'

puts bootstrap["stargazers_count"]