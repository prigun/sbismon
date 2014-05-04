require 'net/http'
require 'json'

url_str = 'http://operator.tensor.ru/auth/service/sbis-rpc-service300.dll'
url_monitor = 'http://operator.tensor.ru/admin/service/sbis-rpc-service300.dll?monitor'

uri = URI(url_str)

req = Net::HTTP::Post.new(uri)
req['Accept'] = 'application/json, text/javascript, */*; q=0.01'
req['Accept-Encoding'] = 'gzip, deflate'
req['Content-Type'] = 'application/json; charset=utf-8'
req['Cookie'] = 'param=admin'

params = {"login" => "admin", "password" => "Xi9baN1KuK"}
data = {"jsonrpc" => "2.0", "protocol" => 2, "method" => "САП.Аутентифицировать", "params" => params, "id" => 1}
req.body = data.to_json

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
end

result = JSON.parse(res.body)

uri_get = URI(url_monitor)

req_get = Net::HTTP::Get.new(uri_get)
req_get['Cookie'] = 'param=admin; sid=' + result["result"]
req_get['Host'] = 'operator.tensor.ru'

#res_get = Net::HTTP.start(uri_get.hostname, uri_get.port) do |http| http.request(req_get) end

http_debug = Net::HTTP.new(uri_get.hostname)
http_debug.set_debug_output($stdout)
res_get = http_debug.request(req_get)


puts res_get.body
