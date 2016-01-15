<#
.Synopsis
    Stop all VMs from a Resource Group
.DESCRIPTION
    Long description
.REQUIREMENTS  
    THis runbook requires the Azure Resource Manager PowerSHell module has been imported into  
    your Azure Automation instance.
.EXAMPLE
    Stop-ResourceGroupVMs -ResourceGroupName "Res1"
.INPUTS
    Inputs to this workflow (if any)
.OUTPUTS
    Output from this workflow (if any)
.NOTES
    AUTHOR: Jing Chang 
    LASTEDIT: April 30, 2014 
.FUNCTIONALITY
    The workflow stop all VMs in a Resource Group
#>
workflow Stop-ResourceGroupVMs
{
    [CmdletBinding()]
    [OutputType([String])]
    Param
    (
        # Param1 ResourceGroupName help description
        [Parameter(Mandatory=$true, 
                   Position=0)]
        [ValidateNotNull()]
        $ResourceGroupName
    )

    Write-Output "Start Stop-ResourceGroupVMs"

    $VMs = Get-AzureRmVM -ResourceGroupName $ResourceGroupName;

    if(-not $VMs)
    { 
        Write-Output "No VMs were found in your Resource Group.";
    }
    else
    { 
        Foreach -parallel ($VM in $VMs) 
        { 
            Write-Output "Starting stopping : $($VM.Name)";
            $ret = Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VM.Name -Force -ErrorAction SilentlyContinue;
            if ($ret.StatusCode -eq "OK")
            {
                Write-Output "Is stopped : $($VM.Name)";
            }
            else
            {
                Write-Verbose "Error on : $($VM.Name)";
            }
        }
    }
    Write-Output "End Stop-ResourceGroupVMs"

}