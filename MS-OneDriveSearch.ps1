<# MS OneDrive Security & Compliance Search 
version 2.0
https://github.com/dwmetz/Axiom-PowerShell
Author: @dwmetz
Function:

Function: This script will generate a Security and Compliance Search to capture OneDrive for a list of custodians.

This PowerShell script will prompt you for the following information:
    * Your user credentials                                          
    * The pathname for the text file that contains a list of user email addresses
    * The name of the Content Search that will be created
    * The search query string (optional. mastering the search query cmd is a dark art.)
 The script will then:
    * Find the OneDrive for Business site for each user in the text file
    * Create and start a Content Search using the above information
#>
Import-module ExchangeOnlineManagement
Import-Module Microsoft.Online.SharePoint.PowerShell
Connect-SPOService -Credential $creds -Url https://yoursite-admin.sharepoint.com -ModernAuth $true -AuthenticationUrl https://login.microsoftonline.com/organizations
Connect-IPPSSession
# Get other required information
$script:inputfile = read-host "Enter the file name of the text file that contains the email addresses for the users you want to search"
$searchName = Read-Host "Enter the name for the new search"
$tempDir = "C:\Temp"
New-Item $tempDir\ODUrls.txt
ForEach ($emailAddress in Get-Content $script:inputfile)
{
    $OneDriveURL = Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Owner -like $emailAddress" | Select-Object -ExpandProperty Url 
    if ($null -ne $OneDriveURL){ 
        Add-content $tempDir\ODUrls.txt $OneDriveURL
        Write-Host "$emailAddress => $OneDriveURL"
    } else {
        Write-Warning "Could not locate OneDrive for $emailAddress"
    }
}
$urls = Get-Content $tempDir\ODUrls.txt | Where-Object {$_ -ne ""}  | ForEach-Object{ $_.Trim() }
# Collect OneDrive 
$search = New-ComplianceSearch -Name $searchName -SharePointLocation $urls -ContentMatchQuery $searchQuery
# Finally, start the search and then display the status
if($search)
{
    Start-ComplianceSearch $search.Name
    Get-ComplianceSearch $search.Name
} 
Remove-Item $tempDir\ODUrls.txt
