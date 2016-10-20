require 'net/https'
require 'uri'
require "nokogiri"

SCHEDULER.every '10s', :first_in => 0 do |job|

  uri = URI.parse("https://vcc-na10.8x8.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE


req1 = Net::HTTP::Get.new("/api/stats/groups/104/activities?d=today")
    req2 = Net::HTTP::Get.new("/api/stats/groups/104/activities?d=today&n=51")
    req3 = Net::HTTP::Get.new("/api/stats/groups/104/activities?d=today&n=101")
      req4 = Net::HTTP::Get.new("/api/stats/groups/104/activities?d=today&n=151")
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
      todayRes1 = doc1.css('tcl-item-id')
        todayRes2 = doc2.css('tcl-item-id')
        todayRes3 = doc3.css('tcl-item-id')
          todayRes4 = doc4.css('tcl-item-id')

cres1 = []
cres2 = []
cres3 = []
cres4 = []



for i in 0..todayRes1.length - 1
  cres1[i] = todayRes1[i].to_s.sub("<tcl-item-id>","").sub("</tcl-item-id>","")
end

for i in 0..todayRes2.length - 1
  cres2[i] = todayRes2[i].to_s.sub("<tcl-item-id>","").sub("</tcl-item-id>","")
end
for i in 0..todayRes3.length - 1
  cres3[i] = todayRes3[i].to_s.sub("<tcl-item-id>","").sub("</tcl-item-id>","")
end
for i in 0..todayRes4.length - 1
  cres4[i] = todayRes4[i].to_s.sub("<tcl-item-id>","").sub("</tcl-item-id>","")
end

cres = cres1 + cres2 + cres3 + cres4


cPay = 0 #id=1
cBillQ = 0 #id=2
cP2P = 0 #id=92
cPayPlan = 0 #102
cInsuranc = 0 #121



cres.each do |me|
 if me =~ /1/ then cPay = cPay+1
 end
 if me =~ /2/ then cBillQ = cBillQ+1
 end
 if me =~ /92/ then cP2P = cP2P+1
 end
 if me =~ /102/ then cPayPlan = cPayPlan+1
 end
 if me =~ /121/ then cInsuranc = cInsuranc+1
 end
end


transactionTotals = cPay,cBillQ,cP2P,cPayPlan,cInsuranc


labels = ['Payment', 'Bill Qs', 'Peer2Peer', 'Payment Plan', 'Insurance']

SCHEDULER.every '10s', :first_in => 0 do |job|

  # Create a random set of data for the chart
  data = Array.new(transactionTotals) 

  send_event('8x8_doughnutchart', {
    segments: [
      {
        value: cPay,
        color: '#F7464A',
        highlight: '#FF5A5E',
        label: 'Payment',
      }, {
        value: cBillQ,
        color: '#46BFBD',
        highlight: '#5AD3D1',
        label: 'Bill Q',
      }, {
        value: cP2P,
        color: '#FDB45C',
        highlight: '#FFC870',
        label: 'Peer2Peer',
      }, {
        value: cPayPlan,
        color: '#949FB1',
        highlight: '#A8B3C5',
        label: 'Payment Plan',
      }, {
        value: cInsuranc,
        color: '#4D5360',
        highlight: '#4D5360',
        label: 'Insurance',
      }
    ]
  })

end
end