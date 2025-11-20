/*Besoin des tables

ipso_vendors_2022_03_15
ipso_vendors_acomba

avant d'exécuter


Iportation DMT =  Supplier
*/

USE dmt_dataloader

UPDATE ipso_vendors_acomba v SET v.SuISOCountryCode = CASE 
  WHEN v.SuCity LIKE '%QC%' THEN 'CA'
  WHEN v.SuCity LIKE '%QUEBEC%' THEN 'CA'
  WHEN v.SuCity LIKE '%QUEB%' THEN 'CA'
  WHEN v.SuCity LIKE '%QUEBE%' THEN 'CA'
  WHEN v.SuCity LIKE '%QUÉBEC%' THEN 'CA'
  WHEN v.SuCity LIKE '%Québec%' THEN 'CA'
  WHEN v.SuCity LIKE '%QUE%' THEN 'CA'
  WHEN v.SuCity LIKE '%ON%' THEN 'CA'
  WHEN v.SuCity LIKE '%ONTARIO%' THEN 'CA'
  WHEN v.SuCity LIKE '%AB%' THEN 'CA'
  WHEN v.SuCity LIKE '%MB%' THEN 'CA'
  WHEN v.SuCity LIKE '%NB%' THEN 'CA'
  WHEN v.SuCity LIKE '%PEI%' THEN 'CA'
  WHEN v.SuCity LIKE '%NS%' THEN 'CA'
  WHEN v.SuCity LIKE '%IA%' THEN 'US'
  WHEN v.SuCity LIKE '%IOWA%' THEN 'US'
  WHEN v.SuCity LIKE '%CT%' THEN 'US'
  WHEN v.SuCity LIKE '%ND%' THEN 'US'
  WHEN v.SuCity LIKE '%ILLINOIS%' THEN 'US'
  WHEN v.SuCity LIKE '%IL%' THEN 'US' 
  WHEN v.SuCity LIKE '%MO%' THEN 'US' 
  WHEN v.SuCity LIKE '%MINNESOTA%' THEN 'US'
  WHEN v.SuCity LIKE '%NE%' THEN 'US' 
  WHEN v.SuCity LIKE '%, CA%' THEN 'US' 
  ELSE 'CA'
END
WHERE v.SuISOCountryCode = '' OR v.SuISOCountryCode IS NULL;

DROP TABLE IF EXISTS epicor_vendors;

CREATE TABLE epicor_vendors
(VendorID int AUTO_INCREMENT PRIMARY KEY)

SELECT 
'CASA' AS Company,
T1.SuNumber AS LegacyVendorID_c,/*Besoin d'un champ UD LegacyVendorID_c*/
REPLACE(UPPER(TRIM(T1.SuName)),',','') AS Name,/*50 Character, si dépasse faut mettre le reste dans Address1 Epicor*/
REPLACE(UPPER(TRIM(T1.SuAddress)),',','') AS Address1,
CASE
  WHEN TRIM(T1.SuCity) LIKE '%,%' THEN REPLACE(UPPER(SUBSTRING(TRIM(T1.SuCity), 1, LENGTH(TRIM(T1.SuCity)) - 4)),',','')
  ELSE UPPER(TRIM(T1.SuCity))
END AS City,
CASE
  WHEN TRIM(T1.SuCity) LIKE '%,%' THEN 
    CASE
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('QUÉB','QUÉ','QUÉBE','(QUÉBE','QUEBEC,''QU','QUE') THEN 'QC'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('ONTARIO','ON','Ontario','STE-CATHARINES, ON','(ONTARIO)','ON L4K 5W3','ON.') THEN 'ON'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('AB') THEN 'AB'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('BC') THEN 'BC'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('MB') THEN 'MB'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('NB') THEN 'NB'
      WHEN UPPER(TRIM(T1.SuCity)) IN ('HALIFAX, NS') THEN 'NS'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('PEI','PE') THEN 'PE'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) IN ('SASKATCHEWAN','SK') THEN 'SK'
      WHEN TRIM(T1.SuIsoCountryCode) = 'US' THEN ''
      ELSE 'QC'
    END
  WHEN TRIM(T1.SuCity) NOT LIKE '%,%' AND TRIM(T1.SuISOCountryCode) = 'CA' THEN 'QC'
  ELSE ''
END AS State,
REPLACE(UPPER(TRIM(T1.SuPostalCode)),' ','') AS ZIP,
CASE 
  WHEN TRIM(T1.SuISOCountryCode) IN ('CA', 'BC', 'ON', 'QC', 'MB') THEN 'CANADA'
  WHEN TRIM(T1.SuISOCountryCode) IN ('US','USA') THEN 'ÉTATS-UNIS'
  WHEN TRIM(T1.SuISOCountryCode) = 'EU' THEN 'ÉTATS-UNIS' -- Decide if EU should map to 'ÉTATS-UNIS' or 'FRANCE'
  WHEN TRIM(T1.SuISOCountryCode) = 'AL' THEN 'ALLEMAGNE'
  WHEN TRIM(T1.SuISOCountryCode) = 'CH' THEN 'CHINE'
  WHEN TRIM(T1.SuISOCountryCode) = 'DK' THEN 'DANEMARK'
  WHEN TRIM(T1.SuISOCountryCode) = 'ES' THEN 'ESPAGNE'
  WHEN TRIM(T1.SuISOCountryCode) = 'FR' THEN 'FRANCE'
  WHEN TRIM(T1.SuISOCountryCode) = 'GT' THEN 'GUATEMALA'
  WHEN TRIM(T1.SuISOCountryCode) = 'IN' THEN 'INDE'
  WHEN TRIM(T1.SuISOCountryCode) = 'IT' THEN 'ITALIE'
  WHEN TRIM(T1.SuISOCountryCode) = 'TR' THEN 'TURQUIE'
  WHEN T1.SuISOCountryCode IS NULL THEN
    CASE
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) = 'QC' THEN 'CANADA'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) = 'BC' THEN 'CANADA'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) = 'ON' THEN 'CANADA'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) = 'MB' THEN 'CANADA'
      WHEN UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1))) = '' AND TRIM(T2.cur_id) = 'CAD' THEN 'CANADA'
    END
  ELSE ''
END AS Country,
/*Canada au long*/
CASE
  WHEN T1.SuPhoneExtention1 <>'' THEN CONCAT(
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 1, 3), '-',
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 4, 3), '-',
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 7, 4), ' #',
  TRIM(T1.SuPhoneExtention1)
  )
  ELSE CONCAT(
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 1, 3), '-',
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 4, 3), '-',
  SUBSTRING(LPAD(TRIM(T1.SuPhoneNumber1), 10, '0'), 7, 4)
) END AS PhoneNum,
TRIM(T2.fax) AS FaxNum,
CASE
  WHEN TRIM(T1.SuEMail) <> '' THEN 
    CASE
      WHEN T1.SuEMail LIKE '%@%' THEN LOWER(TRIM(T1.SuEMail))
      ELSE ''
    END
  WHEN TRIM(T1.SuEMail) = '' AND TRIM(T2.email) <> '' THEN
    CASE
      WHEN T2.email LIKE '%@%' THEN LOWER(TRIM(T2.email))
      ELSE ''
    END
  ELSE ''
END AS EMailAddress,
CASE
  WHEN TRIM(T1.SuISOCountryCode)='CA' OR TRIM(T1.SuISOCountryCode)='CA' THEN 'CAD'
  WHEN TRIM(T1.SuISOCountryCode)='US' OR TRIM(T1.SuISOCountryCode)='USD' THEN 'USD'
  WHEN TRIM(T1.SuISOCountryCode)='EU' OR TRIM(T1.SuISOCountryCode)='EUR' THEN 'EUR'
  ELSE 'CAD'
END AS CurrencyCode,
CASE
  WHEN TRIM(T1.SuLanguage) = '12' THEN 'Frc'
  WHEN TRIM(T1.SuLanguage) = '9' THEN 'Enc'
  WHEN TRIM(T1.SuLanguage) NOT IN ('9','12') THEN 
    CASE
      WHEN TRIM(T2.lng_id) = 'FRA' THEN 'Frc'
      WHEN TRIM(T2.lng_id) = 'ENG' THEN 'Enc'
      WHEN TRIM(T2.lng_id) = '' OR TRIM(T2.lng_id) = '' IS NULL THEN 'Frc'
    END
  ELSE 'Frc'
END AS LangNameID,
CASE UPPER(TRIM(SUBSTRING_INDEX(T1.SuCity, ',', -1)))
  WHEN 'QC' THEN 'QC'
  WHEN 'ON' THEN 'ON'
  WHEN 'AB' THEN 'AB'
  WHEN 'BC' THEN 'BC'
  WHEN 'MB' THEN 'MB'
  WHEN 'NB' THEN 'NB'
  WHEN 'NL' THEN 'NL'
  WHEN 'NT' THEN 'NT'
  WHEN 'NS' THEN 'NS'
  WHEN 'NU' THEN 'NU'
  WHEN 'PE' THEN 'PE'
  WHEN 'SK' THEN 'SK'
  WHEN 'YT' THEN 'YT'
  ELSE 'EX'
END AS TaxRegionCode,
'' AS GroupCode,
CASE
  WHEN T4.PTNumber = '1' THEN '1003' /*2%10 JRS-NET 30 JRS*/
  WHEN T4.PTNumber = '2' THEN '1001' /*1.5 % 10 JOURS*/
  WHEN T4.PTNumber = '3' THEN '1006' /*5%10 JRS-NET30 JRS*/
  WHEN T4.PTNumber = '4' THEN '1006' /*5% 20 JOURS NET 30 JOURS*/
  WHEN T4.PTNumber = '5' THEN '1008' /*NET 10 JOURS*/
  WHEN T4.PTNumber = '6' THEN '1009' /*NET 20 JOURS*/
  WHEN T4.PTNumber = '7' THEN '1010' /*NET 30 JOURS*/ 
  WHEN T4.PTNumber = '8' THEN '1003' /*2,00% 10 Net 30 du mois suivant*/
  WHEN T4.PTNumber = '9' THEN '1000' /*1,00% 10 Net 30 jour(s)*/
  WHEN T4.PTNumber = '10' THEN '1010' /*3,00% 10 Net 30 jour(s)*/
  WHEN T4.PTNumber = '11' THEN '1007' /*Sur réception*/
  WHEN T4.PTNumber = '12' THEN '1004' /*2% 15 jrs net 30 jrs*/
  WHEN T4.PTNumber = '13' THEN '1010' /*1% 15 jours, net 30*/
  WHEN T4.PTNumber = '14' THEN '1002' /*1/2 % 10 JOURS*/
  WHEN T4.PTNumber = '15' THEN '1008' /*Net 15 du mois suivant*/
  WHEN T4.PTNumber = '16' THEN '1006' /*5% POUR LE  10 DU MOIS SUIVANT*/
 /* WHEN T4.PTNumber = '17' THEN '1003'*/ /*2%  POUR LE 15  MOIS SUIVANT*/
  WHEN T4.PTNumber = '18' THEN '1005' /*2% 5 jours*/
  WHEN T4.PTNumber = '19' THEN '1003' /*2,00% 30 Net 60 jour(s)*/
  WHEN T4.PTNumber = '20' THEN '1006' /*5% 15 JOURS NET 30 JOURS*/
  WHEN T4.PTNumber = '21' THEN '1009' /*Net 15 jour(s)*/
  WHEN T4.PTNumber = '22' THEN '1008' /*Net 10 MOIS SUIVANT*/
  WHEN T4.PTNumber = '23' THEN '1001' /*1.75% 15 JOURS NET 30 JOURS*/
  /*WHEN T4.PTNumber = '45' THEN '1011'*/ /*Net 45 jour(s)*/
  /*WHEN T4.PTNumber = '60' THEN '1012'*/ /*Net 60 jour(s)*/
  WHEN T4.PTNumber = '' OR T4.PTNumber = '' IS NULL THEN '1010' /*1.75% 15 JOURS NET 30 JOURS*/
  ELSE '1010'
END AS TermsCode,/*en attente de stephanie*/
CASE
  WHEN TRIM(T2.tpt_id) = 'A090' THEN '1000' /*Livraison Du Fournisseur*/
  WHEN TRIM(T2.tpt_id) = 'A095' THEN '1001' /*Ramassage Client*/
  WHEN TRIM(T2.tpt_id) = 'A096' THEN '1001' /*Ramassage Client*/
  WHEN TRIM(T2.tpt_id) = 'A100' THEN '1002' /*GlS*/
  WHEN TRIM(T2.tpt_id) = 'A102' THEN '1002' /*GlS*/
  WHEN TRIM(T2.tpt_id) = 'A103' THEN '1004' /*UPS*/
  WHEN TRIM(T2.tpt_id) = 'A104' THEN '1005' /*Fedex*/
  WHEN TRIM(T2.tpt_id) = 'A105' THEN '1006' /*STCH*/
  WHEN TRIM(T2.tpt_id) = 'A107' THEN '1007' /*Bourret Transport*/
  WHEN TRIM(T2.tpt_id) = 'A109' THEN '1008' /*Groupe Robert*/
  WHEN TRIM(T2.tpt_id) = 'A110' THEN '1009' /*S.L.B. Transport*/
  WHEN TRIM(T2.tpt_id) = 'AAA' THEN '1011' /*Livraison Casa*/
  WHEN TRIM(T2.tpt_id) = 'B102' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B105' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B300' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B301' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B302' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B305' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B305' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B306' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B307' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B309' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B310' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B500' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B502' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B503' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B504' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B505' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B508' THEN '1011'
  WHEN TRIM(T2.tpt_id) = 'B702' THEN '1011'
  ELSE ''
END AS ShipViaCode,/*Nouveau mapping*/
'EXW' AS DefaultFOB,
'2' AS PMUID,/*Integer, pas texte,ans le futur sera 3, mais implémenté manuellement*/
/*'' AS TaxAuthorityCode,
'' AS TaxPayerID, (pour US...a valider)*/
'False' AS GlobalLock,
'False' AS GlobalVendor,
'True' AS Approved,
'False' AS RcvInspectionReq,
'False' AS PayHold,
'False' AS Inactive,
/*'' AS MinOrderValue,*/
'True' AS PrintLabels,
/*'' AS PaymentReporting,*/
'' AS Comment,/*voir notes si nécessaires*/
'False' AS WebVendor,
'False' AS COD
FROM ipso_vendors_acomba AS T1
LEFT JOIN ipso_vendors T2 ON TRIM(T2.frn_id)=TRIM(T1.SuNumber)
LEFT JOIN acomba_paymenttermsap T4 ON TRIM(T4.PTNumber) = TRIM(T1.SuPaymentTermNumber)
WHERE T1.SuActive = '-1'
ORDER BY T1.SuUnique ASC;

UPDATE epicor_vendors set VendorID = VendorID + 1000000;

ALTER TABLE epicor_vendors MODIFY COLUMN VendorID INT AFTER Company;

ALTER TABLE epicor_vendors MODIFY VendorID VARCHAR(8);

UPDATE epicor_vendors
SET epicor_vendors.VendorID = CONCAT('F', SUBSTRING(epicor_vendors.VendorID, 2))
WHERE epicor_vendors.VendorID IS NOT NULL;

UPDATE epicor_vendors
SET epicor_vendors.PhoneNum = IF(SUBSTRING(epicor_vendors.PhoneNum, 1, 2) = '1-', CONCAT('01-', SUBSTRING(epicor_vendors.PhoneNum, 3)), epicor_vendors.PhoneNum);

UPDATE epicor_vendors
SET epicor_vendors.FaxNum = IF(SUBSTRING(epicor_vendors.FaxNum, 1, 2) = '1-', CONCAT('01-', SUBSTRING(epicor_vendors.FaxNum, 3)), epicor_vendors.FaxNum);

UPDATE epicor_vendors
SET epicor_vendors.Country = 'CANADA' WHERE epicor_vendors.State IN ('QC','ON','AB','BC','MB','NB','NS','PE','SK') AND epicor_vendors.Country = '' OR epicor_vendors.Country IS NULL;

UPDATE epicor_vendors
SET epicor_vendors.Country = 'CANADA' WHERE epicor_vendors.CurrencyCode ='CAD' AND (epicor_vendors.Country = '' OR epicor_vendors.Country IS NULL);

UPDATE epicor_vendors
SET epicor_vendors.Country = 'ÉTATS-UNIS' WHERE epicor_vendors.CurrencyCode ='USD' AND (epicor_vendors.Country = '' OR epicor_vendors.Country IS NULL);

UPDATE epicor_vendors
SET epicor_vendors.Address1 = '' WHERE epicor_vendors.Address1 IS NULL;

UPDATE epicor_vendors
SET epicor_vendors.City = '' WHERE epicor_vendors.City IS NULL;

UPDATE epicor_vendors
SET epicor_vendors.Zip = '' WHERE epicor_vendors.Zip IS NULL;

UPDATE epicor_vendors
SET epicor_vendors.PhoneNum = '' WHERE epicor_vendors.PhoneNum IS NULL;

UPDATE epicor_vendors
SET epicor_vendors.FaxNum = '' WHERE epicor_vendors.FaxNum IS NULL;
/*update for LegalName from name*/
