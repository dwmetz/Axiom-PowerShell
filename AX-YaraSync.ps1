<# AX-YaraSync.ps1
https://github.com/dwmetz/Axiom-PowerShell
Author: @dwmetz
Function:
    Script to sync YARA updates from Reversing Labs Github, 
    archive the existing YARA rules in Axiom, 
    and update Axiom with the new rules.
#>
# Set the working directory to the local git repository for the YARA rules
Set-Location  C:\GitHub\reversinglabs-yara-rules\
# sync the repository; requires github CLI https://cli.github.com/
gh repo sync
# Create local archive directory
mkdir C:\Archives -Force
# Backup the existing YARA rules in Axiom
Get-ChildItem -Path "C:\Program Files\Magnet Forensics\Magnet AXIOM\YARA" | Compress-Archive -DestinationPath C:\Archives\AxiomYARA.zip
# Variable for date/time
$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
# Set the working directory to the Archives location
Set-Location "C:\Archives"
# Rename the archive with timestamp
Get-ChildItem -Filter '*AxiomYARA*' -Recurse | Rename-Item -NewName {$_.name -replace 'AxiomYARA', $timestamp }
# Copy new YARA rules to Axiom
robocopy /s C:\GitHub\reversinglabs-yara-rules\yara "C:\Program Files\Magnet Forensics\Magnet AXIOM\YARA\ReversingLabs"
