<#
$rules – The path to the rules.txt files you have just created.
$name – The name of the relying party trust.
$urn – If you don’t know what this is, just leave it.
$webapp – The URL for the first web application you are going to use. 
#>

$rules = "c:\rules.txt"
$name = "SharePoint Site 1"
$urn = "urn:sharepoint:site1"
$webapp = "https://site1.domain.local"
$endpoint = $webapp + "/_trust/"
[string[]] $urnCollection = $urn, $webapp
 
Add-AdfsRelyingPartyTrust -Name $name -ProtocolProfile WSFederation -WSFedEndpoint $endpoint -Identifier $urnCollection -IssuanceTransformRulesFile $rules
