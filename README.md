# AXIOM-PowerShell

PowerShell scripts to aid investigators when utilizing O365 and Magnet Axiom.

-   AX-Collect.ps1 - This script enables investigator access to a users O365 mailbox.
    Script should be run by Exchange Administrator to grant mailbox delegation permissions.
    Once enabled, sign in using investigator credentials to perform the cloud collection in Axiom. 

-   AX-YaraSync.ps1 - Script to archive the existing YARA rules in Axiom, sync YARA updates from Reversing Labs Github, and then update Axiom with the new rules.

-   MS-ExchangeGroupSearch.ps1 - Collect an O365 mailbox search for a group of custodians.

-   MS-ExchangeGroupODSearch.ps1 - Collect an O365 mailbox & OneDrive search for a group of custodians.

-   MS-OneDriveSearch.ps1 - Script will generate a Security and Compliance Search to capture OneDrive for a list of custodians.

-   MS-TeamsSearch.ps1 - Collect an O365 mailbox search for MS Teams communications.

-   MS-TeamsGroupSearch.ps1 - Collect an O365 mailbox search for MS Teams communications for a group of custodians.
