require 'uri'
require 'net/http'
require 'openssl'

def addparameters(_path, parameters)
    sep = "?";
    parameters.each {
		|key, value|
		_path = _path + sep + key + "=" + value;
		if(sep == "?")
			sep = "&";
		end;
    }
    return _path
end

def makeGETRequest(url, postfields, httpHeader={}, parameters = {})
    method = "GET"
    isHttps = url.lstrip[0..4].eql?("https");
    uri = URI(url)
    response = nil
    http = Net::HTTP.new(uri.host, uri.port)
    if isHttps
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    
    http.start()
    
    response = http.send_request(method, addparameters(uri.path, parameters), postfields, httpHeader)
	
    ret_code = response.code;
    ret_str = response.body;
    return ret_str;
end
def makePOSTRequest(url,  postfields="", httpHeader={},parameters={})
	method = "POST"
    isHttps = url.lstrip[0..4].eql?("https");
    
    uri = URI(url)
    response = nil
    http = Net::HTTP.new(uri.host, uri.port)
    if isHttps
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    http.start()
    response = http.send_request(method, addparameters(uri.path, parameters), postfields, httpHeader)
	
    ret_code = response.code;
    ret_str = response.body;
    return ret_str;
end


