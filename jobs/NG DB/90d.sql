--VW_ACCT_BALANCE

SELECT        v1.practice_id, v1.guar_id, ISNULL(v1.tot, 0) + ISNULL(v2.payment, 0) + ISNULL(v2.adj, 0) AS acct_bal
FROM            dbo.vw_charge_balance AS v1 LEFT OUTER JOIN
                         dbo.vw_trans_balance AS v2 ON v1.guar_id = v2.guar_id AND v1.practice_id = v2.practice_id



--VW_charge_balance
SELECT        pe.practice_id, pe.guar_id, SUM(ISNULL(c.amt, 0)) AS tot
FROM            dbo.patient_encounter AS pe LEFT OUTER JOIN
                         dbo.charges AS c ON pe.practice_id = c.practice_id AND pe.enc_id = c.source_id
WHERE        (c.source_type = 'V') AND (pe.billable_ind = 'Y')
GROUP BY pe.practice_id, pe.guar_id




--VW_trans_balance
SELECT        pe.practice_id, pe.guar_id, SUM(ISNULL(td.paid_amt, 0)) AS payment, SUM(ISNULL(td.adj_amt, 0)) AS adj
FROM            dbo.patient_encounter AS pe LEFT OUTER JOIN
                         dbo.trans_detail AS td ON pe.practice_id = td.practice_id AND pe.enc_id = td.source_id
WHERE        (pe.billable_ind = 'Y') AND (td.source_type = 'V') AND (td.post_ind = 'Y')
GROUP BY pe.practice_id, pe.guar_id



-----------------------------------------------------------------------------------------------------------------------

--vw1 --trans_balance
SELECT        pe.practice_id, pe.guar_id, SUM(ISNULL(td.paid_amt, 0)) AS payment, SUM(ISNULL(td.adj_amt, 0)) AS adj
FROM            dbo.patient_encounter AS pe LEFT OUTER JOIN
                         dbo.trans_detail AS td ON pe.practice_id = td.practice_id AND pe.enc_id = td.source_id
WHERE        (pe.billable_ind = 'Y') AND (td.source_type = 'V') AND (td.post_ind = 'Y') AND (td.create_timestamp >= DATEADD(day, 0, DATEDIFF(dd, 90, GETDATE()))) AND (pe.create_timestamp >= DATEADD(day, 0, 
                         DATEDIFF(dd, 90, GETDATE())))
GROUP BY pe.practice_id, pe.guar_id


--vw2 --Charge_balance
SELECT        pe.practice_id, pe.guar_id, SUM(ISNULL(c.amt, 0)) AS tot
FROM            dbo.patient_encounter AS pe LEFT OUTER JOIN
                         dbo.charges AS c ON pe.practice_id = c.practice_id AND pe.enc_id = c.source_id
WHERE        (c.source_type = 'V') AND (pe.billable_ind = 'Y') AND (pe.create_timestamp >= DATEADD(day, 0, DATEDIFF(dd, 90, GETDATE()))) AND (c.create_timestamp >= DATEADD(day, 0, DATEDIFF(dd, 90, GETDATE())))
GROUP BY pe.practice_id, pe.guar_id



--vw3 --acct_Balance
SELECT        v1.practice_id, v1.guar_id, ISNULL(v1.tot, 0) + ISNULL(v2.payment, 0) + ISNULL(v2.adj, 0) AS acct_bal
FROM            dbo.vw_2 AS v1 LEFT OUTER JOIN
                         dbo.vw_1 AS v2 ON v1.guar_id = v2.guar_id AND v1.practice_id = v2.practice_id




--------------------------------------------------


working for all AR--
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


------------------------my views
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
as practice, SUM(acct_bal) as AR
 from vw_3
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
