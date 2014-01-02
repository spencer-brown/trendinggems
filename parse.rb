require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

blah = Parse::Object.new("Gem")
blah["Name"] = "kirby is cool"
blah["Downloads"] = 0
blah["Github"] = "lolcool.com"
blah.save