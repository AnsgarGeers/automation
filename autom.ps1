#Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $SubMsdnID

$AutomAccount = 'automation-dev'
$RG = 'automation-dev'

$AAccount = Get-AzureRmAutomationAccount -Name $AutomAccount -ResourceGroupName $RG


#Get-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount

<# New Automation Credential
$CredName = "MyCredentialGregor"
$user = "gregor@kurth.ch"
$Description = "Test"
$pw = ConvertTo-SecureString "PassWord!" -AsPlainText -Force
$cred = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $user, $pw
New-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $CredName -Value $cred -Description $Description
#>

<# Set Automation Credential
$CredName = "MyCredentialGregor"
$User = "gregor@kurth.ch"
$Password = ConvertTo-SecureString "Password" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password
Set-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $CredName -Value $Credential
#>

<#
Get-AzureRmAutomationModule -ResourceGroupName $RG -AutomationAccountName $AutomAccount

New-AzureRmAutomationModule -ResourceGroupName $name -Name MyModule -ContentLink "http://Mysite.com/MyModule.zip"; -AutomationAccountName $Name 
do 
{ 
    start-sleep 5 
    $object = Get-AzureRmAutomationModule -ResourceGroupName $name -AutomationAccountName $name | where-object {$_.Name -eq "MyModule"} 
} 
Until(($object.LastModifiedTime - $object.CreationTime).TotalSeconds -gt 1)
#>

#Get-AzureRmAutomationScheduledRunbook -ResourceGroupName $RG -AutomationAccountName $AutomAccount

#New-AzureRmAutomationSchedule -ResourceGroupName $RG -AutomationAccountName $AutomAccount

#Get-AzureRmAutomationRunbook -ResourceGroupName $RG 

Get-AzureRmAutomationVariable -ResourceGroupName $RG -AutomationAccountName $AutomAccount