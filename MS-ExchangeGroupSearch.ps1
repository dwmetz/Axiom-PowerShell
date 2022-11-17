<# MS Exchange Security & Compliance Search 
version 2.0
https://github.com/dwmetz/Axiom-PowerShell
Author: @dwmetz
Function:
    Collect an O365 mailbox search for group of custodians.
    Note this script requires previous installation of the ExchangeOnlineManagement PowerShell module
    See https://docs.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps for more information.
      
This PowerShell script will prompt you for the following information:
    * Your user credentials                                          
    * The pathname for the text file that contains a list of user email addresses
    * The name of the Content Search that will be created
    * The search query string
The script will then:
    * Create and start a Content Search using the above information

Updates:
    17.November.2022 - updated ExchangeOnlineManagement connection, Security & Compliance Center (IPPSSession)

#>
# New Auth
Import-module ExchangeOnlineManagement
Connect-IPPSSession
# Get other required information
$inputfile = read-host "Enter the file name of the text file that contains the email addresses for the users you want to search"
$searchName = Read-Host "Enter the name for the new search"
$searchQuery = Read-Host "[Optional] Enter the search query you want to use"
$emailAddresses = Get-Content $inputfile | Where-Object {$_ -ne ""}  | ForEach-Object{ $_.Trim() }
Write-Host "Creating and starting the search"
$search = New-ComplianceSearch -Name $searchName -ExchangeLocation $emailAddresses -ContentMatchQuery $searchQuery
# Finally, start the search and then display the status
if($search)
{
    Start-ComplianceSearch $search.Name
    Get-ComplianceSearch $search.Name
} 
Write-Host "Search initiated"-ForegroundColor Blue
Write-Host "Proceed to https://protection.office.com/ to download the results."-ForegroundColor Blue