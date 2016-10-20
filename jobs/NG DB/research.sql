SELECT TOP 50 * FROM(SELECT COALESCE(OBJECT_NAME(s2.objectid),'Ad-Hoc') AS ProcName,
  execution_count,s2.objectid,
    (SELECT TOP 1 SUBSTRING(s2.TEXT,statement_start_offset / 2+1 ,
      ( (CASE WHEN statement_end_offset = -1
  THEN (LEN(CONVERT(NVARCHAR(MAX),s2.TEXT)) * 2)
ELSE statement_end_offset END)- statement_start_offset) / 2+1)) AS sql_statement,
       last_execution_time
FROM sys.dm_exec_query_stats AS s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 ) x
WHERE sql_statement NOT like 'SELECT TOP 300 * FROM(SELECT %'
--and OBJECTPROPERTYEX(x.objectid,'IsProcedure') = 1
ORDER BY last_execution_time DESC
INSERT INTO event_ics (event_id, document_id, page_id) VALUES(@SDBPevent_id, @SDBPdocument_id, @SDBPpage_id)
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
select null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Sum(IsNull(chg_amt_0_30, 0)),Sum(IsNull(chg_amt_31_60, 0)),Sum(IsNull(chg_amt_61_90, 0)),Sum(IsNull(chg_amt_91_120, 0)),Sum(IsNull(chg_amt_121_150, 0)),Sum(IsNull(chg_amt_151_180, 0)),Sum(IsNull(chg_amt_181_up, 0)),Sum(IsNull(line_item_amt, 0)),null,null,null,null,null,null, count(*)  from #FA4L0C3QIM1Q f 
UPDATE [Event] WITH (TABLOCKX)
                                                SET [BatchID] = @BatchID,
                                                [ProcessStart] = GETUTCDATE(),
                                                [ProcessHeartbeat] = GETUTCDATE()
                                            FROM (
                                                SELECT TOP 4 [EventID] FROM [Event] WITH (TABLOCKX) WHERE [ProcessStart] is NULL ORDER BY [TimeEntered]
                                                ) AS t1
                                            WHERE [Event].[EventID] = t1.[EventID]

                                            
select top 4
	                                            E.[EventID],
	                                            E.[EventType],
	                                            E.[EventData]
                                            from
	                                            [Event] E WITH (TABLOCKX)
                                            where
	                                            [BatchID] = @BatchID
                                            ORDER BY [TimeEntered]
 
UPDATE [Notifications] WITH (TABLOCKX)
                                        SET [BatchID] = @BatchID,
                                        [ProcessStart] = GETUTCDATE(),
                                        [ProcessHeartbeat] = GETUTCDATE()
                                    FROM (
                                        SELECT TOP 4  [NotificationID] FROM [Notifications] WITH (TABLOCKX) WHERE ProcessStart is NULL and
	                                    (ProcessAfter is NULL or ProcessAfter < GETUTCDATE()) ORDER BY [NotificationEntered]
                                    ) AS t1
                                    WHERE [Notifications].[NotificationID] = t1.[NotificationID]

                                    
select top 4
		                                    -- Notification data
		                                    N.[NotificationID],
		                                    N.[SubscriptionID],
		                                    N.[ActivationID],
		                                    N.[ReportID],
		                                    N.[SnapShotDate],
		                                    N.[DeliveryExtension],
		                                    N.[ExtensionSettings],
                                            N.[Locale],
		                                    N.[Parameters],
		                                    N.[SubscriptionLastRunTime],
		                                    N.[ProcessStart],
		                                    N.[NotificationEntered],
		                                    N.[Attempt],
		                                    N.[IsDataDriven],
		                                    SUSER_SNAME(Owner.[Sid]),
		                                    Owner.[UserName],
		                                    -- Report Data
		                                    O.[Path],
		                                    N.[ReportZone],
		                                    O.[Type],
		                                    SD.NtSecDescPrimary,
                                            N.[Version],
                                            Owner.[AuthType]
	                                    from 
		                                    [Notifications] N with (TABLOCKX) inner join [Catalog] O on O.[ItemID] = N.[ReportID]
		                                    inner join [Users] Owner on N.SubscriptionOwnerID = Owner.UserID
		                                    left outer join [SecData] SD on O.[PolicyID] = SD.[PolicyID] AND SD.AuthType = Owner.AuthType
	                                    where 
		                                    N.[BatchID] = @BatchID
                                    ORDER BY [NotificationEntered]
 
UPDATE #FA4L0C3QIM1Q SET  #FA4L0C3QIM1Q.home_phone = per.home_phone, #FA4L0C3QIM1Q.day_phone = per.day_phone, #FA4L0C3QIM1Q.day_phone_ext = per.day_phone_ext, #FA4L0C3QIM1Q.alt_phone = per.alt_phone, #FA4L0C3QIM1Q.alt_phone_ext = per.alt_phone_ext, #FA4L0C3QIM1Q.sec_home_phone = per.sec_home_phone, #FA4L0C3QIM1Q.cell_phone = per.cell_phone,  #FA4L0C3QIM1Q.email_address = per.email_address FROM person per WHERE #FA4L0C3QIM1Q.person_id = per.person_id AND #FA4L0C3QIM1Q.practice_id = per.practice_id
UPDATE #FA4L0C3QIM1Q SET marketing_desc = mm.description, mrkt_plan = mm.mrkt_plan FROM marketing_mstr mm WHERE #FA4L0C3QIM1Q.practice_id = mm.practice_id and #FA4L0C3QIM1Q.mrkt_plan_id = mm.plan_id
UPDATE #FA4L0C3QIM1Q SET #FA4L0C3QIM1Q.location_name = l.location_name, #FA4L0C3QIM1Q.location_subgrouping1_id = l.location_subgrouping1_id, #FA4L0C3QIM1Q.location_subgrouping2_id = l.location_subgrouping2_id FROM location_mstr l WHERE #FA4L0C3QIM1Q.location_id = l.location_id
UPDATE #FA4L0C3QIM1Q SET department = sim.department, component = sim.component, modality = sim.modality, revenue_code = sim.revenue_code, aftercare_days = sim.aftercare_days, service_item_desc = sim.description From service_item_mstr sim WHERE #FA4L0C3QIM1Q.service_item_id = sim.service_item_id and #FA4L0C3QIM1Q.service_item_lib_id = sim.service_item_lib_id 
UPDATE #FA4L0C3QIM1Q SET chg_amt_181_up = line_item_amt WHERE line_item_age >= 181 
UPDATE #FA4L0C3QIM1Q SET chg_amt_151_180 = line_item_amt WHERE line_item_age >= 151 and line_item_age <= 180
UPDATE #FA4L0C3QIM1Q SET chg_amt_121_150 = line_item_amt WHERE line_item_age >= 121 and line_item_age <= 150
UPDATE #FA4L0C3QIM1Q SET chg_amt_91_120 = line_item_amt WHERE line_item_age >= 91 and line_item_age <= 120
UPDATE #FA4L0C3QIM1Q SET chg_amt_61_90 = line_item_amt WHERE line_item_age >= 61 and line_item_age <= 90
UPDATE #FA4L0C3QIM1Q SET chg_amt_31_60 = line_item_amt WHERE line_item_age >= 31 and line_item_age <= 60
INSERT INTO event_data_trail (unique_id, event_id, location, field, old_value, new_value, description) VALUES(@SDBPunique_id, @SDBPevent_id, @SDBPlocation, @SDBPfield, @SDBPold_value, @SDBPnew_value, @SDBPdescription)
UPDATE #FA4L0C3QIM1Q SET chg_amt_0_30 = line_item_amt WHERE line_item_age >= 0 and line_item_age <= 30
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
UPDATE #FA4L0C3QIM1Q SET exception_amt = line_item_amt WHERE line_item_age < 0 
UPDATE #FA4L0C3QIM1Q SET line_item_age = datediff(dd,begin_date_of_service,'20161012')WHERE source_type = 'I' AND begin_date_of_service is not null
UPDATE #FA4L0C3QIM1Q SET line_item_age = datediff(dd,begin_date_of_service,'20161012')WHERE begin_date_of_service is not null
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = emp.name, person_id = emp.employer_id, enc_nbr = ac.acct_nbr, address_line_1 = emp.address_line_1, address_line_2 = emp.address_line_2, city = emp.city, state = emp.state, zip = emp.zip, country_id = emp.country_id, county_id = emp.county_id FROM accounts ac, employer_mstr emp WHERE #FA4L0C3QIM1Q.source_type = 'B' and #FA4L0C3QIM1Q.practice_id = ac.practice_id and #FA4L0C3QIM1Q.enc_id = ac.acct_id and ac.guar_type = 'E' and ac.guar_id = emp.employer_id
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = isnull(per.last_name,'')  +  ', '  +  isnull(per.first_name,'')  +  ' '  +  CASE WHEN (( ISNULL(nickname, '') <> '') ) THEN isnull(per.middle_name,'')  +  ' ('  +  isnull(per.nickname,'')  +  ')' else isnull(per.middle_name,'') end, enc_nbr = ac.acct_nbr, address_line_1 = per.address_line_1, address_line_2 = per.address_line_2, city = per.city, state = per.state, zip = per.zip, country_id = per.country_id, county_id = per.county_id, person_nbr = per.person_nbr FROM accounts ac, person per WHERE #FA4L0C3QIM1Q.source_type = 'B' and #FA4L0C3QIM1Q.practice_id = ac.practice_id and #FA4L0C3QIM1Q.enc_id = ac.acct_id and ac.guar_type = 'P' and ac.guar_id = per.person_id
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = emp.name, person_id = ac.acct_id, enc_nbr = inv.invoice_nbr, address_line_1 = emp.address_line_1, address_line_2 = emp.address_line_2, city = emp.city, state = emp.state, zip = emp.zip, country_id = emp.country_id, county_id = emp.county_id FROM invoices inv, accounts ac, employer_mstr emp WHERE #FA4L0C3QIM1Q.source_type = 'I' and #FA4L0C3QIM1Q.practice_id = inv.practice_id and #FA4L0C3QIM1Q.enc_id = inv.invoice_id and inv.practice_id = ac.practice_id and inv.acct_id = ac.acct_id and ac.guar_type = 'E' and ac.guar_id = emp.employer_id
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = isnull(per.last_name,'')  +  ', '  +  isnull(per.first_name,'')  +  ' '  +  CASE WHEN (( ISNULL(nickname, '') <> '') ) THEN isnull(per.middle_name,'')  +  ' ('  +  isnull(per.nickname,'')  +  ')' else isnull(per.middle_name,'') end, person_id = ac.acct_id, enc_nbr = inv.invoice_nbr, address_line_1 = per.address_line_1, address_line_2 = per.address_line_2, city = per.city, state = per.state, zip = per.zip, country_id = per.country_id, county_id = per.county_id, person_nbr = per.person_nbr FROM invoices inv, accounts ac, person per  WHERE #FA4L0C3QIM1Q.source_type = 'I' and #FA4L0C3QIM1Q.practice_id = inv.practice_id and #FA4L0C3QIM1Q.enc_id = inv.invoice_id and inv.practice_id = ac.practice_id and inv.acct_id = ac.acct_id and ac.guar_type = 'P' and ac.guar_id = per.person_id
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = 'Acct: '  +  emp.name, enc_nbr = ac.acct_nbr, address_line_1 = emp.address_line_1, address_line_2 = emp.address_line_2, city = emp.city, state = emp.state, zip = emp.zip, country_id = emp.country_id, county_id = emp.county_id FROM accounts ac, employer_mstr emp WHERE #FA4L0C3QIM1Q.source_type = 'A' and #FA4L0C3QIM1Q.practice_id = ac.practice_id and #FA4L0C3QIM1Q.enc_id = ac.acct_id and ac.guar_type = 'E' and ac.guar_id = emp.employer_id
UPDATE #FA4L0C3QIM1Q SET guar_id = ac.guar_id, name = 'Acct: '  +  isnull(per.last_name,'')  +  ', '  +  isnull(per.first_name,'')  +  ' '  +  CASE WHEN (( ISNULL(nickname, '') <> '') ) THEN isnull(per.middle_name,'')  +  ' ('  +  isnull(per.nickname,'')  +  ')' else isnull(per.middle_name,'') end, enc_nbr = ac.acct_nbr, address_line_1 = per.address_line_1, address_line_2 = per.address_line_2, city = per.city, state = per.state, zip = per.zip, country_id = per.country_id, county_id = per.county_id, person_nbr = per.person_nbr, patient_age_unformatted = DATEDIFF(YY, per.date_of_birth, getdate()) - CASE WHEN( (MONTH(per.date_of_birth)*100 + DAY(per.date_of_birth)) > (MONTH(getdate())*100 + DAY(getdate())) ) THEN 1 ELSE 0 END, patient_age_dos_unformatted = DATEDIFF(YY, per.date_of_birth, begin_date_of_service) - CASE WHEN( (MONTH(per.date_of_birth)*100 + DAY(per.date_of_birth)) > (MONTH(begin_date_of_service)*100 + DAY(begin_date_of_service)) ) THEN 1 ELSE 0 END FROM accounts ac, person per WHERE #FA4L0C3QIM1Q.source_type = 'A' and #FA4L0C3QIM1Q.practice_id = ac.practice_id and #FA4L0C3QIM1Q.enc_id = ac.acct_id and ac.guar_type = 'P' and ac.guar_id = per.person_id
UPDATE #FA4L0C3QIM1Q SET #FA4L0C3QIM1Q.practice_name = pr.practice_name FROM practice pr WHERE #FA4L0C3QIM1Q.practice_id = pr.practice_id 
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
UPDATE #FA4L0C3QIM1Q SET financial_class_desc = ml.mstr_list_item_desc FROM mstr_lists ml WHERE #FA4L0C3QIM1Q.financial_class = ml.mstr_list_item_id and ml.mstr_list_type = 'fin_class'
UPDATE #FA4L0C3QIM1Q SET financial_class_desc = 'Self Pay', payer_name = 'Self Pay' WHERE #FA4L0C3QIM1Q.payer_id is null and #FA4L0C3QIM1Q.source_type = 'V' 


UPDATE #FA4L0C3QIM1Q SET name = isnull(per.last_name,'')  +  ', '  +  isnull(per.first_name,'')  +  ' '  +  CASE WHEN (( ISNULL(nickname, '') <> '') ) THEN isnull(per.middle_name,'')  +  ' ('  +  isnull(per.nickname,'')  +  ')' else isnull(per.middle_name,'') end, date_of_birth = per.date_of_birth, patient_age = per.date_of_birth, address_line_1 = per.address_line_1, address_line_2 = per.address_line_2, city = per.city, state = per.state, zip = per.zip, country_id = per.country_id, county_id = per.county_id, uds_homeless_status_id = per.uds_homeless_status_id, uds_migrant_worker_status_id = per.uds_migrant_worker_status_id,  uds_language_barrier_id = per.uds_language_barrier_id, uds_primary_med_coverage_id = per.uds_primary_med_coverage_id, person_nbr = per.person_nbr, med_rec_nbr = pat.med_rec_nbr, ethnicity_id = per.ethnicity_id, uds_tribal_affiliation_id = per.uds_tribal_affiliation_id, uds_blood_quantum_id = per.uds_blood_quantum_id, uds_veteran_status = per.uds_veteran_status, uds_consent_to_treat_ind = per.uds_consent_to_treat_ind, uds_school_hlth_ctr_id = per.uds_school_hlth_ctr_id, uds_pub_hsng_pri_care_id = per.uds_pub_hsng_pri_care_id, patient_age_unformatted = DATEDIFF(YY, per.date_of_birth, getdate()) - CASE WHEN( (MONTH(per.date_of_birth)*100 + DAY(per.date_of_birth)) > (MONTH(getdate())*100 + DAY(getdate())) ) THEN 1 ELSE 0 END, patient_age_dos_unformatted = DATEDIFF(YY, per.date_of_birth, begin_date_of_service) - CASE WHEN( (MONTH(per.date_of_birth)*100 + DAY(per.date_of_birth)) > (MONTH(begin_date_of_service)*100 + DAY(begin_date_of_service)) ) THEN 1 ELSE 0 END, uds_descendancy_id = per.uds_decendancy_id, uds_ihs_elig_status_id = per.uds_ihs_elig_status_id, uds_tribal_class_id = per.uds_tribal_class_id, uds_consent_to_treat_date = per.uds_consent_to_treat_date, community_code_id = per.community_code_id, primary_dental_prov_id = per.primary_dental_prov_id,  Patient_age_in_months  =DATEDIFF(MM, per.date_of_birth, getdate()) - CASE WHEN (DAY(per.date_of_birth) > DAY(getdate())) THEN 1 ElSE 0 END , patient_age_in_months_on_dos=DATEDIFF(MM, per.date_of_birth, begin_date_of_service) - CASE WHEN (DAY(per.date_of_birth) > DAY(begin_date_of_service)) THEN 1 ElSE 0 END  FROM person per, patient pat WHERE #FA4L0C3QIM1Q.person_id = per.person_id and #FA4L0C3QIM1Q.practice_id = pat.practice_id and per.person_id = pat.person_id
INSERT INTO event_audit_mstr (event_id, category_id, action_id, action_type, event_timestamp, station_id, source_product_description, process_id, enterprise_id, practice_id, person_id, event_message, create_timestamp, created_by, modify_timestamp, modified_by, site_id, hash_code, location_Id, event_timestamp_timezone) VALUES(@SDBPevent_id, @SDBPcategory_id, @SDBPaction_id, @SDBPaction_type, @SDBPevent_timestamp, @SDBPstation_id, @SDBPsource_product_description, @SDBPprocess_id, @SDBPenterprise_id, @SDBPpractice_id, @SDBPperson_id, @SDBPevent_message, getdate(), @SDBPcreated_by, getdate(), @SDBPmodified_by, @SDBPsite_id, @SDBPhash_code, @SDBPlocation_Id, @SDBPevent_ts_timezone)
UPDATE #FA4L0C3QIM1Q SET phys_last_name = pm.last_name, phys_first_name = pm.first_name, phys_middle_name = pm.middle_name, provider_subgrp1_id = pm.provider_subgrouping1_id, provider_subgrp2_id = pm.provider_subgrouping2_id FROM provider_mstr pm WHERE #FA4L0C3QIM1Q.rendering_provider_id = pm.provider_id 
UPDATE #FA4L0C3QIM1Q SET line_item_amt = isnull(charge_amt,0) + isnull(trans_tot_amt,0) FROM #TR4L0C3QIM1U tr WHERE #FA4L0C3QIM1Q.charge_id = tr.charge_id 
INSERT into #TR4L0C3QIM1U(practice_id, charge_id, trans_tot_amt) SELECT td.practice_id, td.charge_id, sum(isnull(td.adj_amt,0)) + sum(isnull(td.paid_amt,0)) FROM trans_detail td (nolock), transactions tr (nolock), #FA4L0C3QIM1Q sFin WHERE sFin.charge_id = td.charge_id AND td.post_ind = 'Y' AND td.trans_id = tr.trans_id and td.practice_id = tr.practice_id  and tr.closing_date <=  '20161012' GROUP BY td.practice_id, td.charge_id 












select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [ReportServer].[sys].[filetable_updates_2105058535] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [ReportServerTempDB].[sys].[filetable_updates_2105058535] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [NGAuditProd].[sys].[filetable_updates_2105058535] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [NGDevl].[sys].[filetable_updates_34551698] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [NGDemo].[sys].[filetable_updates_34551698] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [NGAuditDevl].[sys].[filetable_updates_2105058535] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [Mirth_Prod].[sys].[filetable_updates_2105058535] with (readpast) order by table_id
select table_id, item_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid
 from [NGAuditTest].[sys].[filetable_updates_2105058535] with (readpast) order by table_id