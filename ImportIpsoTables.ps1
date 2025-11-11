#Exécution: 19:33min

chcp 65001

# Define the path to the log file
$logFilePath = "C:\Devart\log\ImportIpsoTables.log"

#Define the path to dbforge
$dbforgePath = "C:\Program Files\Devart\dbForge Studio for MySQL\dbforgemysql.com"

#Define the path for template
$templatePath = "C:\Devart\ImportTemplates"

#Define the path for Acomba excel file
$acombaPath = "C:\Devart\Acomba"


#Define the database
$dbName = "dmt_dataloader"
$dbConnection = "User Id=root;Host=localhost;Character Set=utf8"
$dbPassword = "Securite611!"


# Start transcript logging
Start-Transcript -Path $logFilePath

Write-Host ""
Write-Host "IMPORTING IPSO DATA IN MYSQL ON W11-SERVICES"
Write-Host ""


Write-Host "IMPORTING: ipso_climst"
#Import ipso_climst
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_climst.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_climst" /errormode:abort

#Write-Host "IMPORTING: ipso_clishp"
#Import ipso_clishp
#& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_clishp.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_clishp" /errormode:abort

#Write-Host "IMPORTING: ipso_contact"
#Import ipso_contact
#& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_contact.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_contact" /errormode:abort

Write-Host "IMPORTING: ipso_eclbom"
#Import ipso_eclbom
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_eclbom.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_eclbom" /errormode:abort

Write-Host "IMPORTING: ipso_eclops"
#Import ipso_eclops
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_eclops.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_eclops" /errormode:abort

Write-Host "IMPORTING: ipso_enstock"
#Import ipso_enstock
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_enstock.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_enstock" /errormode:abort

#Write-Host "IMPORTING: ipso_frncat"
#Import ipso_frncat
#& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_frncat.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_frncat" /errormode:abort

#Write-Host "IMPORTING: ipso_frnitm"
#Import ipso_frnitm
#& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_frnitm.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_frnitm" /errormode:abort

Write-Host "IMPORTING: ipso_invcmt"
#Import ipso_invcmt
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_invcmt.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_invcmt" /errormode:abort

Write-Host "IMPORTING: ipso_invfil"
#Import ipso_invfil
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_invfil.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_invfil" /errormode:abort

Write-Host "IMPORTING: ipso_itmdoc"
#Import ipso_itmdoc
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_itmdoc.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_itmdoc" /errormode:abort

Write-Host "IMPORTING: ipso_prix"
#Import ipso_prix
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_prix.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_prix" /errormode:abort

Write-Host "IMPORTING: ipso_opsfil"
#Import ipso_opsfil
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_opsfil.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_opsfil" /errormode:abort

Write-Host "IMPORTING: ipso_revmst"
#Import ipso_revmst
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_revmst.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_revmst" /errormode:abort

Write-Host "IMPORTING: ipso_stkcat"
#Import ipso_stkcat
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_stkcat.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_stkcat" /errormode:abort

Write-Host "IMPORTING: ipso_stkconv"
#Import ipso_stkconv
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_stkconv.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_stkconv" /errormode:abort

Write-Host "IMPORTING: ipso_stkdesc"
#Import ipso_stkdesc
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_stkdesc.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_stkdesc" /errormode:abort

Write-Host "IMPORTING: ipso_stklev"
#Import ipso_stklev
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_stklev.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_stklev" /errormode:abort

Write-Host "IMPORTING: ipso_sttfil"
#Import ipso_sttfil
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_stklev.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.ipso_stklev" /errormode:abort

Write-Host "IMPORTING: ipso_vendors_acomba"
#Import Acomba Suppliers (Le fichier Excel se met à jour automatiquement 2X/jour, pas besoin de l'exécuter avant)
& $dbforgePath /dataimport /templatefile:"$templatePath\ipso_vendors_acomba.dit" /connection:"$dbConnection" /password:$dbPassword /inputfile:"$acombaPath\Suppliers.xlsx" /table:"dmt_dataloader.ipso_vendors_acomba" /errormode:abort

#Write-Host "IMPORTING: pdm_documents"
#Import pdm_documents
#& $dbforgePath /dataimport /templatefile:"$templatePath\pdm_documents.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.pdm_documents" /errormode:abort

#Write-Host "IMPORTING: pdm_revisions"
#& $dbforgePath /dataimport /templatefile:"$templatePath\pdm_revisions.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.pdm_revisions" /errormode:abort


Write-Host ""
Write-Host "DONE IMPORTING IPSO DATA IN MYSQL ON W11-SERVICES"
Write-Host ""

#pause

# Stop transcript logging
Stop-Transcript