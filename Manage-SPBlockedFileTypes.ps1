function Get-SPBlockedFileType {
    <#
    .Synopsis
     This function can be used to retrieve blocked file types for a SharePoint Web Application.
    .Description
     This PowerShell function uses the SharePoint Object Model to get all file
     types in the BlockedFileExtensions property for a Web Application.
    .Example
     C:\PS>Get-SPBlockedFileType -WebApplication http://intranet
     This example gets blocked file types for a SharePoint Web Application at http://intranet.
    .Notes
     Name: Get-SPBlockedFileType
     Author: Ryan Dennis
     Last Edit: 6/14/2012
     Keywords: Get-SPBlockedFileType,Add-SPBlockedFileType,Remove-SPBlockedFileType
    .Link

    .Inputs
     None
    .Outputs
     None
    #Requires -Version 2.0
    #>
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]$WebApplication
    )
    $WebApp = Get-SPWebApplication $WebApplication
    $Extensions = $WebApp.BlockedFileExtensions
    $Extensions | ForEach-Object {Write-Host $_}
    }

    function Add-SPBlockedFileType {
        <#
        .Synopsis
         This function can be used to add a blocked file type for a SharePoint Web Application.
        .Description
         This PowerShell function uses the SharePoint Object Model to add file
         types to the BlockedFileExtensions property for a Web Application.
        .Example
         C:\PS>Add-SPBlockedFileType -WebApplication http://intranet -Extension ps1
         This example adds the ps1 file type to the BlockedFileExtensions collection
         for a SharePoint Web Application at http://intranet.
        .Notes
         Name: Add-SPBlockedFileType
         Author: Ryan Dennis
         Last Edit: 6/14/2012
         Keywords: Get-SPBlockedFileType,Add-SPBlockedFileType,Remove-SPBlockedFileType
        .Link
     
        .Inputs
         None
        .Outputs
         None
        #Requires -Version 2.0
        #>
        [CmdletBinding()]
        Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]$WebApplication,
        [Parameter(Mandatory=$true)][System.String]$Extension
        )
        $WebApp = Get-SPWebApplication $WebApplication
        $Extensions = $WebApp.BlockedFileExtensions
        $Extensions.Add($Extension)
        $WebApp.Update()
        }


function Remove-SPBlockedFileType {
<#
.Synopsis
 This function can be used to remove a blocked file type from a SharePoint Web Application.
.Description
 This PowerShell function uses the SharePoint Object Model to remove file
 types from the BlockedFileExtensions property for a Web Application.
.Example
 C:\PS>Remove-SPBlockedFileType -WebApplication http://intranet -Extension ps1
 This example removes the ps1 file type from the BlockedFileExtensions collection
 of a SharePoint Web Application at http://intranet.
.Notes
 Name: Remove-SPBlockedFileType
 Author: Ryan Dennis
 Last Edit: 6/14/2012
 Keywords: Get-SPBlockedFileType,Add-SPBlockedFileType,Remove-SPBlockedFileType
.Link

.Inputs
 None
.Outputs
 None
#Requires -Version 2.0
#>
[CmdletBinding()]
Param(
[Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
[Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]$WebApplication,
[Parameter(Mandatory=$true)][System.String]$Extension
)
$WebApp = Get-SPWebApplication $WebApplication
$Extensions = $WebApp.BlockedFileExtensions
$Ext = $Extensions.Remove($Extension)
if($Ext -eq $true){
Write-Warning "Filetype $($Extension) has been removed from Web Application $(($WebApp).Name)"
}
else{
Write-Warning "Unable to delete filetype $($Extension) from Web Application $(($WebApp).Name)"
}
$WebApp.Update()
}
