#Tribridge version
#run using the AX management shell if not add this correct path -->  import-module "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"
# process:
#	create temporary schema 
#	import modelstore to temporary schema 
#	stop AOS
#	apply modelstore from temp schema
# 	drop temp schema


#region Variables
 

$targetserver = "AJMTESTSQLVM"
$targetdb = "AXDEV"
$backFileName = "\\ajmtestdevvm\DynamicsAX\tmp\BLD1007.axmodelstore"
 
#endregion
 
#region Work
 
Initialize-AXModelStore –Server $targetserver -Database $targetdb –SchemaName Temp
Import-AXModelStore -Server $targetserver -Database $targetdb -SchemaName Temp -File $backFileName -NoPrompt
# Only works in Console
if (!$psISE)
{
 Write-Host "Press any key to when you have stopped the AOS to continue the Import..."
 $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
 Write-Host ""
}
Import-AXModelStore -Server $targetserver -Database $targetdb -Apply Temp  -NoPrompt
Initialize-AXModelStore -Server $targetserver -Database $targetdb –Drop Temp -NoPrompt
 
"Completed!"
 
#endregion
