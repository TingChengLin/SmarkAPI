require 'net/http'

# sign up
def sign_up
  #uri = URI('http://localhost:3000/users')
  uri = URI('http://54.249.26.55/users')
  res = Net::HTTP.post_form(uri, 'email' => 'lintingy@gmail.com', 'password' => '12345678')
  puts res.body
end

def sign_out
  #url = 'localhost'
  #request = Net::HTTP.new(url, 3000)
  url = 'api.smark.cc'
  request = Net::HTTP.new(url, 80)
  params = { 'auth_token' => 'pkupkVjwrdTPyqkmp5gp' }
  request.delete("/users/sign_out?#{URI.encode_www_form(params)}")
end

def sign_in
  uri = URI('http://localhost:3000/users/sign_in')
  res = Net::HTTP.post_form(uri, 'email' => 'vv@storysensecomputing.com', 'password' => '12345678')
  puts res.body
end

# bookmark
def create
  uri = URI('http://54.249.26.55/bookmarks')
  res = Net::HTTP.post_form(uri,
                            'url' => 'http://danielkummer.github.io/git-flow-cheatsheet/',
                            'title' => 'git flow cheatsheet',
                            'description' => 'git-flow are a set of git extensions to provide high-level repository operations for Vincent Driessen\'s branching model. This cheatsheet shows the basic usage and effect of git-flow operations',
                            'tags[]' => 'git',
                            'auth_token' => 'pgn94qjcyuDwHJQWBXcp')
  puts res.body
end

