chcp 65001

# Define the path to the log file
$logFilePath = "C:\Devart\log\CreateMasterfilesLog.log"

#Define the path to dbforge
$DbForgeExePath = "C:\Program Files\Devart\dbForge Studio for MySQL\dbforgemysql.com"

#Define the path for template
$templatePath = "C:\Devart\ImportTemplates"

#Define the path for SQL Files
$sqlFilesPath = "\\data-01\Informatiques\8900 Epicor Implantation\MasterFiles\MySqlRequests"

#Define the database
$dbName = "dmt_dataloader"
$DbConnection = "User Id=root;Host=localhost;Port=3306;Database=$dbName;Character Set=utf8"
$dbPassword = "Securite611!"

# Start transcript logging
Start-Transcript -Path $logFilePath

Write-Host ""
Write-Host "CREATING MASTER FILES IN MYSQL ON W11-SERVICES"
Write-Host ""


Write-Host "`n`n"
Write-Host "CREATING Vendors table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Vendors.sql"
Write-Host "`n`n"
Write-Host "CREATING Vendors_PurchasePoint table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Vendors_PurchasePoint.sql"
Write-Host "`n`n"
Write-Host "CREATING Vendors_Contact table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Vendors_Contact.sql"
Write-Host "`n`n"
Write-Host "CREATING SupplierGLControl table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\SupplierGLControl.sql"
Write-Host "`n`n"


Write-Host "DROPPING TABLES BEFORE IMPORTATION"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\DeleteTables.sql"

Write-Host "`n`n"
Write-Host "IMPORTING: epicor_vendors to epicortest_vendors"
& $DbForgeExePath /dataimport /templatefile:"$templatePath\epicor_vendor.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.epicortest_vendors" /errormode:abort /create

Write-Host "`n`n"
Write-Host "IMPORTING: epicor_vendors_ud to epicortest_vendors_ud"
& $DbForgeExePath /dataimport /templatefile:"$templatePath\epicor_vendor_ud.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.epicortest_vendors_ud" /errormode:abort /create


& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\SupplierBank.sql"
#& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\QualifiedManufacturer.sql"
Write-Host "`n`n"
Write-Host "CREATING Customer table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Customer.sql"


Write-Host "`n`n"
Write-Host "IMPORTING: pdm_documents"
& $DbForgeExePath /dataimport /templatefile:"$templatePath\pdm_import_documents.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.pdm_documents" /errormode:abort /create

Write-Host "`n`n"
Write-Host "IMPORTING: pdm_revisions"
& $DbForgeExePath /dataimport /templatefile:"$templatePath\pdm_import_revisions.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.pdm_revisions" /errormode:abort /create

Write-Host "`n`n"
Write-Host "IMPORTING: pdm_status"
& $DbForgeExePath /dataimport /templatefile:"$templatePath\pdm_import_status.dit" /connection:"$dbConnection" /password:$dbPassword /table:"$dbName.pdm_status" /errormode:abort /create


Write-Host "`n`n"
Write-Host "CREATING CustomerContact table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\CustomerContact.sql"
    #& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\PartLot.sql"
Write-Host "`n`n"
Write-Host "CREATING Part_Purchased table"
    & $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Part_Purchased.sql"
Write-Host "`n`n"
Write-Host "CREATING Part_Purchased_serialised table"
    & $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Part_Purchased_serialised.sql"
Write-Host "`n`n"
Write-Host "CREATING Part_Manufactured table"
    & $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Part_Manufactured.sql"
Write-Host "`n`n"
Write-Host "CREATING Part_Manufactured_Serialised table"
    & $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Part_Manufactured_Serialised.sql"
Write-Host "`n`n"
Write-Host "CREATING Part table"
& $DbForgeExePath /execute /connection:"$DbConnection" /password:$dbPassword /inputfile "$sqlFilesPath\Part.sql"
    

Write-Host ""
Write-Host "DONE CREATING MASTER FILES IN MYSQL ON W11-SERVICES"
Write-Host ""

#pause

# Stop transcript logging
Stop-Transcript


