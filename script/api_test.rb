require 'net/http'

# sign up
def sign_up
  uri = URI('http://localhost:3000/users')
  res = Net::HTTP.post_form(uri, 'email' => 'vv@storysensecomputing.com', 'password' => '12345678')
  puts res.body
end

def sign_out
  url = 'localhost'
  request = Net::HTTP.new(url, 3000)
  params = { 'auth_token' => 'pkupkVjwrdTPyqkmp5gp' }
  request.delete("/users/sign_out?#{URI.encode_www_form(params)}")
end

def sign_in
  uri = URI('http://localhost:3000/users/sign_in')
  res = Net::HTTP.post_form(uri, 'email' => 'vv@storysensecomputing.com', 'password' => '12345678')
  puts res.body
end
pkupkVjwrdTPyqkmp5gp
