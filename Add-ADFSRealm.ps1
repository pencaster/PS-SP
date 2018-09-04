$urn = "urn:sharepoint:site2"
 
$ap = Get-SPTrustedIdentityTokenIssuer
$uri = new-object System.Uri("https://site2.domain.local")
$ap.ProviderRealms.Add($uri, $urn)
$ap.Update()