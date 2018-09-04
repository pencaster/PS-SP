$path = "C:\RootCA.cer"
$root = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($path)
if ($null -ne $root)
{
 New-SPTrustedRootAuthority -Name "Enterprise Root CA" -Certificate $cert
}
