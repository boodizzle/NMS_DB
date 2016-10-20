require 'tiny_tds'

SCHEDULER.every '600s', :first_in => 0 do |job|

client = TinyTds::Client.new(:username => 'sqladmin', :password => 'temp123!', :host => '10.115.0.15', :database => 'NGProd', :port => '1433')
 prsql = "select login_id as user_name, tasks_touched as tasks from all_tasks"
 icsql = "select login_id as user_name, tasks_touched as tasks 
from all_tasks
where 
(
login_id = 'cnewell' or
login_id = 'jgarner' or
login_id = 'ssousa' or
login_id = 'enastasi' or
login_id = 'ngutierrez' 
)
order by login_id"

  results1 = client.execute(icsql)
     acctitemsIC = results1.map do |row|
row = {
 :label => row['user_name'],
 :value => row['tasks']
  }
end
  results2 = client.execute(prsql)
     acctitemsPR = results2.map do |row|
row = {
 :label => row['user_name'],
 :value => row['tasks']
  }
end


  send_event('icTasks', {items: acctitemsIC})
  send_event('prTasks', {items: acctitemsPR})
 end



