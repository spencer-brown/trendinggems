require 'parse-ruby-client'

Parse.init :application_id => "YVWoiSDLzCG30Tnviio15fFqLBHoa6OIPnMjWb7D",
           :api_key        => "WOK8BtMCMMZJc1PW40Fz8RLF9coAsXklLmL387Ve"

blah = Parse::Object.new("Gem")
blah["Name"] = "kirby is gay"
blah["Downloads"] = 0
blah["Github"] = "lolgay.com"
blah.save