require 'net/http'
require 'json'

url_str = 'http://fix-operator.tensor.ru/auth/service/sbis-rpc-service300.dll'

uri = URI(url_str)

req = Net::HTTP::Post.new(uri)
req.add_field('Accept', 'application/json, text/javascript, */*; q=0.01')
req.add_field('Accept-Encoding', 'gzip, deflate')
req.add_field('Content-Type', 'application/json; charset=utf-8')

params = {"login" => "admin", "password" => "admin"}
data = {"jsonrpc" => "2.0", "protocol" => 2, "method" => "САП.Аутентифицировать", "params" => params, "id" => 1}
req.body = data.to_json

res = Net::HTTP.start(uri.hostname, uri.port) do |http| http.request(req) end

result = JSON.parse(res.body)
puts result["result"]
