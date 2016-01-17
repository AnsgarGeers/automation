#

#Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $SubMsdnID

$AutomAccount = 'automation-dev'
$RG = 'automation-dev'

#Accounts

#Get-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount

$AccCredName = "myCred1"

$AccUserName = "gregor@kurth.ch"
$AccPassword = "PassWord!1"
$AccDescription = "Test2"


$ACred = $null;
$ACred = Get-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $AccCredName -ErrorAction SilentlyContinue

    if (-not ($ACred))
    {
        Write-Output "1"
        $pw = ConvertTo-SecureString $AccPassword -AsPlainText -Force
        $cred = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $AccUserName, $pw
        New-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $AccCredName -Value $cred -Description $AccDescription

    }
    else
    {
        $pw = ConvertTo-SecureString $AccPassword -AsPlainText -Force
        $cred = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $AccUserName, $pw
        Set-AzureRmAutomationCredential -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $AccCredName -Value $cred -Description $AccDescription
    }




# Variables

$VarName = "00001-Test"
$VarValue = "Ds sis sddf sf2"
$VarDescription = "rr"
$VarEncrypted = $false


Set-AutomationVariable -ResourceGroupName $RG -AutomationAccountName $AutomAccount -VariableName $VarName -VariableValue $VarValue -VariableDescription $VarDescription -VariableEncrypted $VarEncrypted

#Tags
$RBName = ""
Set-AzureRmResourceGroup tag-demo -Tag @( @{ Name="project"; Value="tags" }, @{ Name="env"; Value="demo"} )

PS C:\> $tags = (Get-AzureRmResourceGroup -Name tag-demo).Tags
PS C:\> $tags += @{Name="status";Value="approved"}
PS C:\> Set-AzureRmResourceGroup tag-demo -Tag $tags

#https://azure.microsoft.com/en-us/documentation/articles/resource-group-using-tags/

Set-AzureRmAutomationRunbook -ResourceGroupName $RG -AutomationAccountName $AutomAccount -Name $RBName -Tags


# Module
#DSC
