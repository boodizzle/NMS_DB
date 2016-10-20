require 'net/https'
require 'uri'
require "nokogiri"
 
 
SCHEDULER.every '20s', :first_in => 0 do |job|

#results 1-50
  uri1 = URI.parse("https://vcc-na10.8x8.com")
  http1 = Net::HTTP.new(uri1.host, uri1.port)
  http1.use_ssl = true
  http1.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req1 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today")
  req1.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response1 = http1.request(req1)
  res1 = (response1.body)
  doc1 = Nokogiri::XML(res1)
  result1 = doc1.css('interaction-id').count

  
  #51-100
    uri2 = URI.parse("https://vcc-na10.8x8.com")
  http2 = Net::HTTP.new(uri2.host, uri2.port)
  http2.use_ssl = true
  http2.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req2 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=51")
  req2.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response2 = http2.request(req2)
  res2 = (response2.body)
  doc2 = Nokogiri::XML(res2)
  result2 = doc2.css('interaction-id').count

  #101 - 150
    uri3 = URI.parse("https://vcc-na10.8x8.com")
  http3 = Net::HTTP.new(uri3.host, uri3.port)
  http3.use_ssl = true
  http3.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req3 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=101")
  req3.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response3 = http3.request(req3)
  res3 = (response3.body)
  doc3 = Nokogiri::XML(res3)
  result3 = doc3.css('interaction-id').count

#151-200
     uri4 = URI.parse("https://vcc-na10.8x8.com")
  http4 = Net::HTTP.new(uri4.host, uri4.port)
  http4.use_ssl = true
  http4.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req4 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=151")
  req4.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response4 = http4.request(req4)
  res4 = (response4.body)
  doc4 = Nokogiri::XML(res4)
  result4 = doc4.css('interaction-id').count

#201-250
   uri5 = URI.parse("https://vcc-na10.8x8.com")
  http5 = Net::HTTP.new(uri5.host, uri5.port)
  http5.use_ssl = true
  http5.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req5 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=201")
  req5.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response5 = http5.request(req5)
  res5 = (response5.body)
  doc5 = Nokogiri::XML(res5)
  result5 = doc5.css('interaction-id').count

#results 1-50
  uri_out = URI.parse("https://vcc-na10.8x8.com")
  http_out  = Net::HTTP.new(uri_out.host, uri_out.port)
  http_out.use_ssl = true
  http_out.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req_out1 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today")
  req_out1.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response_out1 = http_out.request(req_out1)
  res_out1 = (response_out1.body)
  doc_out1 = Nokogiri::XML(res_out1)
  result_out1 = doc_out1.css('interaction-id').count

  #51-100
  req_out2 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today&n=51")
  req_out2.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response_out2 = http_out.request(req_out2)
  res_out2 = (response_out2.body)
  doc_out2 = Nokogiri::XML(res_out2)
  result_out2 = doc_out2.css('interaction-id').count

  #ABANDON CALLS
  uri = URI.parse("https://vcc-na10.8x8.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req = Net::HTTP::Get.new("https://vcc-na10.8x8.com/api/rtstats/stats/queue/105")
  req.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response = http.request(req)
  res = (response.body)
  doc = Nokogiri::XML(res)
         abanresult = doc.css('day-abandoned')
  abandonCall = []
#clean up tags
for i in 0..abanresult.length - 1
  abandonCall[i] = abanresult[i].to_s.sub("<day-abandoned>","").sub("</day-abandoned>","")
end
#variable for string into int
abandonTotal = abandonCall[0].to_i



#adding them up!
inresultsTotal = result1 + result2 + result3 + result4 + result5 
outresultsTotal = result_out1 + result_out2
resultsTotal  = inresultsTotal + outresultsTotal + abandonTotal




status = case resultsTotal
  when 0 then 'danger'
  when 1..3 then 'warning'
  else 'ok'
end

  send_event('8x8_Calls_Today', current: resultsTotal, status: status)

 end

