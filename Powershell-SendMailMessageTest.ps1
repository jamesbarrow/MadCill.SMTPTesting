$date = Get-Date -Format yyyy-MM-dd
$time = get-date -Format HH:mm:ss

$username = $null
$password = $null
#$username = "domain\user"
#$password = 'password'

$smtpHost = "localhost"
$port = 25

$to = "test@localhost"
$from = "from@localhost"

$subject = "This is a test message - $($date + "|" + $time)"
$body = "This is a test body"


if($username -ne $null) {
    $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)

    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer $smtpHost -Port $port -Credential $cred
}
else{
    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer $smtpHost -Port $port
}