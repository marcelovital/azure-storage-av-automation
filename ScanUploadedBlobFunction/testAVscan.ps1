$FilePath = "C:\Users\MarceloVital\Downloads\EICAR\eicar.com.txt";
$URL = 'https://10.150.169.36/scan';

$fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
$fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
$boundary = [System.Guid]::NewGuid().ToString(); 
$LF = "`r`n";

$bodyLines = ( 
    "--$boundary",
    "Content-Disposition: form-data; name=`"file`"; filename=`"temp.txt`"",
    "Content-Type: application/octet-stream$LF",
    $fileEnc,
    "--$boundary--$LF" 
) -join $LF

Invoke-RestMethod -Uri $URL -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines -SkipCertificateCheck