require "rubygems"
require "active_support/core_ext"

require 'net/http'
require 'net/https'

def create
  uri = URI('http://localhost:3000/bookmarks')
  res = Net::HTTP.post_form(uri,
                            :url => "url",
                            :title => "title",
                            :description => "description",
                            :tags => ["ruby", "rails"],
                            :uid => 1)
  puts res.body
end

uri = URI('http://localhost:3000/bookmarks')
req = Net::HTTP::Post.new(uri)
req.set_form_data(:url => "url",
                            :title => "title",
                            :description => "description",
                            :tags => ["ruby", "rails"],
                            :uid => 1)

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end


uri = URI('http://www.example.com/search.cgi')
res = Net::HTTP.post_form(uri, 'q' => ['ruby', 'perl'], 'max' => '50')
puts res.body

curl -i -X POST -d 'url=url&description=description&tags[]=aaa&tags[]=rails&uid=2' http://localhost:3000/bookmarks



curl -i -X POST -d 'vote=1&bookmark_id=1&user_id=1' http://localhost:3000/bookmarks/elect

