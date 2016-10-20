require 'net/https'
require 'uri'
require "nokogiri"

SCHEDULER.every '60s', :first_in => 0 do |job|

  uri = URI.parse("https://vcc-na10.8x8.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

#Today result
  req1 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today")
    req2 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=51")
    req3 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=101")
      req4 = Net::HTTP::Get.new("/api/stats/queues/105/interactions?d=today&n=151")
  req1.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
    req2.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
    req3.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
      req4.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response1 = http.request(req1)
    response2 = http.request(req2)
    response3 = http.request(req3)
      response4 = http.request(req4)
  res1 = (response1.body)
    res2 = (response2.body)
    res3 = (response3.body)
      res4 = (response4.body)
  doc1 = Nokogiri::XML(res1)
    doc2 = Nokogiri::XML(res2)
    doc3 = Nokogiri::XML(res3)
      doc4 = Nokogiri::XML(res4)
      todayRes1 = doc1.css('create-timestamp')
        todayRes2 = doc2.css('create-timestamp')
        todayRes3 = doc3.css('create-timestamp')
          todayRes4 = doc4.css('create-timestamp')
          ################################ABANDONED
      abanTodayres1 = doc1.css('abandon-timestamp')
        abanTodayres2 = doc2.css('abandon-timestamp')
        abanTodayres3 = doc3.css('abandon-timestamp')
          abanTodayres4 = doc4.css('abandon-timestamp')
          ###############################################

##############outbound
      req5 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today")
      req6 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today&n=51")
      req7 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today&n=101")
      req8 = Net::HTTP::Get.new("/api/stats/queues/113/interactions?d=today&n=151")

        req5.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
      req6.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
        req7.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
      req8.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
    
     response5 = http.request(req5)
     response6 = http.request(req6)
     response7 = http.request(req7)
     response8 = http.request(req8)
    
     res5 = (response5.body)
     res6 = (response6.body)
     res7 = (response7.body)
     res8 = (response8.body)

     doc5 = Nokogiri::XML(res5)
     doc6 = Nokogiri::XML(res6)
     doc7 = Nokogiri::XML(res7)
     doc8 = Nokogiri::XML(res8)
    
     todayRes5 = doc5.css('create-timestamp')
     todayRes6 = doc6.css('create-timestamp')
     todayRes7 = doc7.css('create-timestamp')
     todayRes8 = doc8.css('create-timestamp')

#######################

cres1 = []
cres2 = []
cres3 = []
cres4 = []

abancres1 = []
abancres2 = []
abancres3 = []
abancres4 = []

cres1_out = []
cres2_out = []
cres3_out = []
cres4_out = []


for i in 0..todayRes1.length - 1
  cres1[i] = todayRes1[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end

for i in 0..todayRes2.length - 1
  cres2[i] = todayRes2[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
for i in 0..todayRes3.length - 1
  cres3[i] = todayRes3[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
for i in 0..todayRes4.length - 1
  cres4[i] = todayRes4[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
######################ABANDONED#################
          for i in 0..abanTodayres1.length - 1
  abancres1[i] = abanTodayres1[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end

for i in 0..abanTodayres1.length - 2
  abancres2[i] = abanTodayres2[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end

for i in 0..abanTodayres3.length - 1
  abancres3[i] = abanTodayres3[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end

for i in 0..abanTodayres4.length - 1
  abancres4[i] = abanTodayres4[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
################Outbound
for i in 0..todayRes5.length - 1
  cres1_out[i] = todayRes5[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
for i in 0..todayRes6.length - 1
  cres2_out[i] = todayRes6[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
for i in 0..todayRes7.length - 1
  cres3_out[i] = todayRes7[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
for i in 0..todayRes8.length - 1
  cres4_out[i] = todayRes8[i].to_s.sub("<create-timestamp>","").sub("</create-timestamp>","")
end
################

#Array
cres = cres1 + cres2 + cres3 + cres4
cresaban = abancres1 + abancres2 + abancres3 + abancres4
cres_out = cres1_out + cres2_out + cres3_out + cres4_out
#cres = todayRes1+todayRes2+todayRes3+todayRes4

#Objects & Values
am7 = 0
am8 = 0
am9 = 0
am10 = 0
am11 = 0
pm12 = 0
pm1 = 0
pm2 = 0
pm3 = 0
pm4 = 0 
pm5 = 0
pm6 = 0
########################################abandoned
abanam7 = 0
abanam8 = 0
abanam9 = 0
abanam10 = 0
abanam11 = 0
abanpm12 = 0
abanpm1 = 0
abanpm2 = 0
abanpm3 = 0
abanpm4 = 0 
abanpm5 = 0
######################################OUTbound
outam7 = 0
outam8 = 0
outam9 = 0
outam10 = 0
outam11 = 0
outpm12 = 0
outpm1 = 0
outpm2 = 0
outpm3 = 0
outpm4 = 0 
outpm5 = 0
######################################


#Loop If/Then
cres.each do |me|
 if me =~ /T07/ then am7=am7+1
 end
 if me =~ /T08/ then am8=am8+1
 end
 if me =~ /T09/ then am9=am9+1
 end
 if me =~ /T10/ then am10=am10+1
 end
 if me =~ /T11/ then am11=am11+1
 end
 if me =~ /T12/ then pm12=pm12+1
 end
 if me =~ /T13/ then pm1=pm1+1
 end
 if me =~ /T14/ then pm2=pm2+1
 end
 if me =~ /T15/ then pm3=pm3+1
 end
 if me =~ /T16/ then pm4=pm4+1
 end
 if me =~ /T17/ then pm5=pm5+1
end
end
#################################abandoned
cresaban.each do |me|
 if me =~ /T07/ then abanam7=abanam7+1
 end
 if me =~ /T08/ then abanam8=abanam8+1
 end
 if me =~ /T09/ then abanam9=abanam9+1
 end
 if me =~ /T10/ then abanam10=abanam10+1
 end
 if me =~ /T11/ then abanam11=abanam11+1
 end
 if me =~ /T12/ then abanpm12=abanpm12+1
 end
 if me =~ /T13/ then abanpm1=abanpm1+1
 end
 if me =~ /T14/ then abanpm2=abanpm2+1
 end
 if me =~ /T15/ then abanpm3=abanpm3+1
 end
 if me =~ /T16/ then abanpm4=abanpm4+1
 end
 if me =~ /T17/ then abanpm5=abanpm5+1
end
end

######################OUTBOUND
cres_out.each do |me|
 if me =~ /T07/ then outam7=outam7+1
 end
 if me =~ /T08/ then outam8=outam8+1
 end
 if me =~ /T09/ then outam9=outam9+1
 end
 if me =~ /T10/ then outam10=outam10+1
 end
 if me =~ /T11/ then outam11=outam11+1
 end
 if me =~ /T12/ then outpm12=outpm12+1
 end
 if me =~ /T13/ then outpm1=outpm1+1
 end
 if me =~ /T14/ then outpm2=outpm2+1
 end
 if me =~ /T15/ then outpm3=outpm3+1
 end
 if me =~ /T16/ then outpm4=outpm4+1
 end
 if me =~ /T17/ then outpm5=outpm5+1
end
end
###############################
chartValuesIN = am7, am8, am9, am10, am11, pm12, pm1, pm2, pm3, pm4, pm5, pm6
chartValuesABAN = abanam7, abanam8, abanam9, abanam10, abanam11, abanpm12, abanpm1, abanpm2, abanpm3, abanpm4, abanpm5
chartValuesOUT = outam7, outam8, outam9, outam10, outam11, outpm12, outpm1, outpm2, outpm3, outpm4, outpm5

labels = ['8a', '9a', '10a', '11a','12a','1p','2p','3p','4p','5p', '6p']
data = [
  {
    label: 'Inbound',
    fillColor: 'rgba(151,187,205,0.5)',
    strokeColor: 'rgba(151,187,205,0.8)',
    highlightFill: 'rgba(151,187,205,0.75)',
    highlightStroke: 'rgba(151,187,205,1)',
    data: Array.new(chartValuesIN)
  },

  {
    label: 'Outbound',
    fillColor: 'rgba(220,220,220,0.5)',
    strokeColor: 'rgba(220,220,220,0.8)',
    highlightFill: 'rgba(220,220,220,0.75)',
    highlightStroke: 'rgba(220,220,220,1)',
    data: Array.new(chartValuesOUT)
  },

    {
    label: 'Abandoned',
    fillColor: 'rgba(198,18,74,0.5)',
    strokeColor: 'rgba(198,18,74,0.8)',
    highlightFill: 'rgba(198,18,74,0.75)',
    highlightStroke: 'rgba(198,18,74,1)',
    data: Array.new(chartValuesABAN)
  },

]
options = { scaleFontColor: '#fff' }

send_event('8x8_Line_chart_hour', { labels: labels, datasets: data, options: options })
end