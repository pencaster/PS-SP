$certBytes=(Get-AdfsCertificate -CertificateType Token-Signing)[0].Certificate.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
 
[System.IO.File]::WriteAllBytes("c:\ADFSSigning.cer", $certBytes)
