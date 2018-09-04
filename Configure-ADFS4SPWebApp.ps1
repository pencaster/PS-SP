$path = “C:\ADFSSigning.cer”
$root = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($path)
New-SPTrustedRootAuthority -Name "ADFS Token Signing Cert" -Certificate $cert
# next step 
# Map the email address, UPN, Group Memberships and SID from ADFS
$emailClaimMap = New-SPClaimTypeMapping -IncomingClaimType "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress" -IncomingClaimTypeDisplayName "EmailAddress" -SameAsIncoming
$upnClaimMap = New-SPClaimTypeMapping -IncomingClaimType "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn" -IncomingClaimTypeDisplayName "UPN" -SameAsIncoming
$roleClaimMap = New-SPClaimTypeMapping -IncomingClaimType "http://schemas.microsoft.com/ws/2008/06/identity/claims/role" -IncomingClaimTypeDisplayName "Role" -SameAsIncoming
$roleClaimMap = New-SPClaimTypeMapping -IncomingClaimType "http://schemas.microsoft.com/ws/2008/06/identity/claims/role" -IncomingClaimTypeDisplayName "Role" -SameAsIncoming
 
# Update the following to match the details entered earlier if you changed them
$realm = "urn:sharepoint:site1"
$signInURL = "https://adfs.domain.local/adfs/ls"
$ap = New-SPTrustedIdentityTokenIssuer -Name ADFS -Description ADFS -realm $realm -ImportTrustCertificate $cert -ClaimsMappings $emailClaimMap,$upnClaimMap,$roleClaimMap,$sidClaimMap -SignInUrl $signInURL -IdentifierClaim $emailClaimmap.InputClaimType

#configure SharePoint WebApp for ADFS
$webApp = Get-SPWebApplication -Identity "https://site1.domain.local"
$sts = Get-SPTrustedIdentityTokenIssuer "ADFS"
Set-SPWebApplication -Identity $webApp -AuthenticationProvider $sts -Zone "Default"