add-pssnapin *exchange* -erroraction SilentlyContinue

$i = 0    

$Mailboxes = Get-Mailbox

foreach($Mailbox in $Mailboxes)
{
   $Results = foreach( $Mailbox in $Mailboxes ){
        
   Get-MailboxFolderStatistics -Identity $Mailbox.DistinguishedName | Where {$_.Name -like '*/*'}
        
    }
    
   $i++
   Write-Progress -activity "Checking mailboxes" -status "Checked so far: $i of $($Mailboxes.Count)" -percentComplete (($i / $Mailboxes.Count)  * 100)
}

if (-NOT ($null -eq $Results)){
    $Results | convertto-csv -NoTypeInformation | out-file .\FolderNameAudit.csv -fo -en ascii
} Else {
    Write-Output "No folder name issues found"
}