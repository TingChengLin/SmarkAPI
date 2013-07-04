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
  params = { 'auth_token' => 'pgn94qjcyuDwHJQWBXcp' }
  request.delete("/users/sign_out?#{URI.encode_www_form(params)}")
end

def sign_out_post
  uri = URI('http://api.smark.cc/users/sign_out')
  res = Net::HTTP.post_form(uri, 'auth_token' => 'WxtWcWV6vXyWoyzonKXC' )
  puts res.body
end


def sign_in
  uri = URI('http://localhost:3000/users/sign_in')
  res = Net::HTTP.post_form(uri, 'email' => 'vv@storysensecomputing.com', 'password' => '12345678')
  puts res.body
end

def subscribe
  #uri = URI('http://localhost:3000/users')
  uri = URI('http://54.249.26.55/users/subscribe')
  res = Net::HTTP.post_form(uri, 'tag_id' => 706, 'auth_token' => "pgn94qjcyuDwHJQWBXcp")
  puts res.body
end


# bookmark
def create
  uri = URI('http://54.249.26.55/bookmarks')
  res = Net::HTTP.post_form(uri,
                            'url' => 'http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html',
                            'title' => 'git-flow 备忘清单',
                            'description' => '这个备忘清单展示了 git-flow 的基本操作和效果。',
                            'tags[]' => 'git',
                            'auth_token' => 'pgn94qjcyuDwHJQWBXcp')
  puts res.body
end

