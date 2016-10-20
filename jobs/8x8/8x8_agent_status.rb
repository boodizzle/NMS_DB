require 'net/https'
require 'uri'
require "nokogiri"
 
 
SCHEDULER.every '30s', :first_in => 0 do |job|

#Agents Status'
  uri1 = URI.parse("https://vcc-na10.8x8.com")
  http1 = Net::HTTP.new(uri1.host, uri1.port)
  http1.use_ssl = true
  http1.verify_mode = OpenSSL::SSL::VERIFY_NONE
  req1 = Net::HTTP::Get.new("/api/rtstats/stats/agents.xml")
  req1.basic_auth("newportmedsolutions", "2c0b8d15471087b9a378c41d6aad4044")
  response1 = http1.request(req1)
  res1 = (response1.body)
  doc1 = Nokogiri::XML(res1)
  
  #parsing the data
=begin
  agentName = doc1.css('agent-name')
  aname = []
=end
  agentName = doc1.css('agent-id')
  aname = []

  agentStatus = doc1.css('agent-status')
  astat = []

  
#removing headers using replacements replacement
=begin
for i in 0..agentName.length - 1
  aname[i] = agentName[i].to_s.sub("<agent-name>","").sub("</agent-name>","")
end
=end
for i in 0..agentName.length - 1
  aname[i] = agentName[i].to_s.sub("<agent-id>","").sub("</agent-id>","")
end

for i in 0..agentStatus.length - 1
  astat[i] = agentStatus[i].to_s.sub("<agent-status>","").sub("</agent-status>","")
end





status0 = ""
status1 = ""
status2 = ""
status3 = ""
status4 = ""
status5 = ""
status6 = ""
status7 = ""
status8 = ""
status9 = ""
status10 = ""
status11 = ""
status12 = ""
status13 = ""
status14 = ""
status15 = ""
status16 = ""

if astat[0] == "9" 
 status0 = 'Offline'
  elsif astat[0] == "0" 
  status0 = 'Available' 
    elsif astat[0] == "2" 
    status0 = 'Busy'
      elsif astat[0] == "3" 
      status0 = 'Post'
        elsif astat[0] == "4" 
        status0 = 'On Break'
          elsif astat[0] == "5" 
          status0 = 'Wrk Offline'
            else 
            status0 = 'Error ' + astat[0]
end            
if astat[1] == "9" 
 status1 = 'Offline'
  elsif astat[1] == "0" 
  status1 = 'Available' 
    elsif astat[1] == "2" 
    status1 = 'Busy'
      elsif astat[1] == "3" 
      status1 = 'Post'
        elsif astat[1] == "4" 
        status1 = 'On Break'
          elsif astat[1] == "5" 
          status1 = 'Wrk Offline'
            else 
            status1 = 'Error ' + astat[1]
end
if astat[2] == "9" 
 status2 = 'Offline'
  elsif astat[2] == "0" 
  status2 = 'Available' 
    elsif astat[2] == "2" 
    status2 = 'Busy'
      elsif astat[2] == "3" 
      status2 = 'Post'
        elsif astat[2] == "4" 
        status2 = 'On Break'
          elsif astat[2] == "5" 
          status2 = 'Wrk Offline'
            else 
            status2 = 'Error ' + astat[2]
end
if astat[3] == "9" 
 status3 = 'Offline'
  elsif astat[3] == "0" 
  status3 = 'Available' 
    elsif astat[3] == "2" 
    status3 = 'Busy'
      elsif astat[3] == "3" 
      status3 = 'Post'
        elsif astat[3] == "4" 
        status3 = 'On Break'
          elsif astat[3] == "5" 
          status3 = 'Wrk Offline'
            else 
            status3 = 'Error ' + astat[3]
end
if astat[4] == "9" 
 status4 = 'Offline'
  elsif astat[4] == "0" 
  status4 = 'Available' 
    elsif astat[4] == "2" 
    status4 = 'Busy'
      elsif astat[4] == "3" 
      status4 = 'Post'
        elsif astat[4] == "4" 
        status4 = 'On Break'
          elsif astat[4] == "5" 
          status4 = 'Wrk Offline'
            else 
            status4 = 'Error ' + astat[4]
end
if astat[5] == "9" 
 status5 = 'Offline'
  elsif astat[5] == "0" 
  status5 = 'Available' 
    elsif astat[5] == "2" 
    status5 = 'Busy'
      elsif astat[5] == "3" 
      status5 = 'Post'
        elsif astat[5] == "4" 
        status5 = 'On Break'
          elsif astat[5] == "5" 
          status5 = 'Wrk Offline'
            else 
            status5 = 'Error ' + astat[5]
end
if astat[6] == "9" 
 status6 = 'Offline'
  elsif astat[6] == "0" 
  status6 = 'Available' 
    elsif astat[6] == "2" 
    status6 = 'Busy'
      elsif astat[6] == "3" 
      status6 = 'Post'
        elsif astat[6] == "4" 
        status6 = 'On Break'
          elsif astat[6] == "5" 
          status6 = 'Wrk Offline'
            else 
            status6 = 'Error ' + astat[6]
end

  #encapsulation [] causes the data to input
  #calling each individual item within array
 acctitems = [
 {label: aname[0], value: status0},
 {label: aname[1], value: status1}, #test user
 {label: aname[2], value: status2},
 {label: aname[3], value: status3},
 {label: aname[4], value: status4},
 {label: aname[5], value: status5},
 {label: aname[6], value: status6},
 {label: aname[7], value: status7}
 ]
 


  send_event('8x8_Agent_Status', {items: acctitems} )
  end