require 'tiny_tds'

SCHEDULER.every '1200s', :first_in => 0 do |job|

client = TinyTds::Client.new(:username => 'sqladmin',:password => 'temp123!',:host => '10.115.0.15',:database => 'NGProd',:port => '1433')
sql= "
select 
CASE
WHEN practice_id = '0027' THEN 'COS'
WHEN practice_id = '0029' THEN 'HOH'
WHEN practice_id = '0009' THEN 'Gillman'
WHEN practice_id = '0030' THEN 'NASA'
WHEN practice_id = '0026' THEN 'OCHSS'
WHEN practice_id = '0035' THEN 'Kim'
WHEN practice_id = '0017' THEN 'SOCO'
WHEN practice_id = '0013' THEN 'Mora'
WHEN practice_id = '0037' THEN 'Dobkin'
WHEN practice_id = '0033' THEN 'GLBO'
WHEN practice_id = '0038' THEN 'OCOSMG'
WHEN practice_id = '0007' THEN 'B&S'
ELSE 'Please Update Qry'
END
as practice, 
'$'+FORMAT(SUM(acct_bal),'###,###,###.##') as AR
 from vw_acct_balance
 where 
 (
practice_id = '0027' OR
practice_id = '0029' OR
practice_id = '0009' OR
practice_id = '0030' OR
practice_id = '0026' OR
practice_id = '0035' OR
practice_id = '0017' OR
practice_id = '0013' OR
practice_id = '0037' OR
practice_id = '0033' OR
practice_id = '0038' OR
practice_id = '0007' 
)
group by practice_Id
"




  # Execute the query
  results = client.execute(sql)
    acctitems = results.map do |row|
row = {
 :label => row['Practice'],
 :value => row['AR']
  }
end

  send_event('Aging_AR_INS_COL', {items: acctitems})
end

=begin
SELECT CASE WHEN practice = 'Brain And Spine Surgeons Of OC'      THEN 'B&S'
            WHEN practice = 'California Orthopaedic Specialists'      THEN 'COS'
			WHEN practice = 'Hands On Hands Rehabilitation Center Inc'      THEN 'HOH'
			WHEN practice = 'Michael Gillman MD Inc'      THEN 'Gillman'
			WHEN practice = 'Neurovascular And Spine Associates'      THEN 'NASA'
			WHEN practice = 'Orange County Hand Surgery Specialists'      THEN 'OCHSS'
			WHEN practice = 'Richard B Kim MD MS Inc'      THEN 'Kim'
			WHEN practice = 'South Orange County Orthopaedics Inc'      THEN 'SOCO'
			WHEN practice = 'Steve A Mora MD Inc'      THEN 'Mora'
			WHEN practice = 'William Dobkin MD Inc'      THEN 'Dobkin'
			WHEN practice = 'Greater Long Beach Orthopaedic'      THEN 'GLBO'
                             ELSE 'taco'
       END AS Practice, total
FROM ar_90d





select practice as practice, total as total from ar_90d


=end