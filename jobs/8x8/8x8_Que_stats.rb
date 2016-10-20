require 'net/https'
require 'uri'
require "nokogiri"
 
 
SCHEDULER.every '5s', :first_in => 0 do |job|

#COLLECTIONS QUE
  uri1 = URI.parse("https://vcc-na10.8x8.com")
  http1 = Net::HTTP.new(uri1.host, uri1.port)
  http1.use_ssl = true
  http1.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req1 = Net::HTTP::Get.new("https://vcc-na10.8x8.com/api/rtstats/stats/queue/105")
  req1.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response1 = http1.request(req1)
  res1 = (response1.body)
  doc1 = Nokogiri::XML(res1)
  result1 = doc1.css('day-avg-wait-time')
    result2 = doc1.css('day-avg-duration')
      result3 = doc1.css('longest-wait-time')
        result4 = doc1.css('queue-size')
         result5 = doc1.css('day-abandoned')
#VM QUE
  req2 = Net::HTTP::Get.new("https://vcc-na10.8x8.com/api/rtstats/stats/queue/107")
  req2.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response2 = http1.request(req2)
  res2 = (response2.body)
  doc1 = Nokogiri::XML(res1)
     result6 = doc1.css('queue-size')




  avgWait = []
  avgDur = []
  lngWait = []
  queSize = []
  abandonCall = []
  vmQUE = []

#clean up tags



  for i in 0..result1.length - 1
  avgWait[i] = result1[i].to_s.sub("<day-avg-wait-time>","").sub("</day-avg-wait-time>","")
end
  for i in 0..result2.length - 1
  avgDur[i] = result2[i].to_s.sub("<day-avg-duration>","").sub("</day-avg-duration>","")
end
  for i in 0..result3.length - 1
  lngWait[i] = result3[i].to_s.sub("<longest-wait-time>","").sub("</longest-wait-time>","")
end
  for i in 0..result4.length - 1
  queSize[i] = result4[i].to_s.sub("<queue-size>","").sub("</queue-size>","")
end
for i in 0..result5.length - 1
  abandonCall[i] = result5[i].to_s.sub("<day-abandoned>","").sub("</day-abandoned>","")
end
#####VM QUE
for i in 0..result6.length - 1
  vmQUE[i] = result6[i].to_s.sub("<queue-size>","").sub("</queue-size>","")
end



label1 = "Calls In Que"
label2 = "Longest Waiting"
label3 = "Average Wait"
label4 = "Average Duration"
label5 = "Abandoned"
label6 = "Voice Mails"


 acctitems = [
 {label: label1, value: queSize},
 {label: label2, value: lngWait},
 {label: label3, value: avgWait},
 {label: label4, value: avgDur},
 {label: label5, value: abandonCall},
 {label: label6, value: vmQUE}
]

  send_event('8x8_que_stats', items: acctitems)


 end

 #https://vcc-na10.8x8.com/api/stats/channels/2/interactions?d=today-1d={offset}&{query%20vars}