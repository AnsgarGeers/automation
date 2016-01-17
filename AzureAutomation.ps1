<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function set-AutomationVariable
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ResourceGroupName,

        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $AutomationAccountName,

        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        $VariableName,

        # VariableValue help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        $VariableValue,

        # VariableDescriptio help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        $VariableDescription = "",
        
        # VariableEncrypted help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=5)]
        $VariableEncrypted = $false
    )

    Begin
    {
        Write-Verbose "Start set-AutomationVariable";
    }
    Process
    {
        $AVar = $null;
        $AVar = Get-AzureRmAutomationVariable -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName -Name $VariableName -ErrorAction SilentlyContinue

        If (-not($AVar))
        {
            New-AzureRmAutomationVariable -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName -Name $VariableName -Value $VariableValue -Description $VariableDescription -Encrypted $VariableEncrypted
        }
        else
        {
            Write-Verbose "Variable exists: $($AVar.Name)"
            if ($AVar.Value -ne $VariableValue)
            {
                Write-Verbose "Variable Value not equal"
                Write-Verbose "Old Value: $($AVar.Value)"
                Set-AzureRmAutomationVariable  -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName -Value $VariableValue
                Write-Verbose "Set new Value: $($VariableValue)"
            }

        }
    }
    End
    {
        Write-Verbose "End set-AutomationVariable";
    }
}


<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function set-AutomationCredential
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ResourceGroupName,

        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $AutomationAccountName,

        # VariableName help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        $CredentialName,

        # VariableValue help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        $CredentialUserName,

        # VariableValue help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        $CredentialPassword,

        # CredentialDescriptio help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=5)]
        $CredentialDescription = ""

    )

    Begin
    {
        Write-Verbose "Start set-AutomationVariable";
    }
    Process
    {
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
    }
    End
    {
        Write-Verbose "End set-AutomationVariable";
    }
}