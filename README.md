# MadCill.SMTPTesting
A collection of utility pages and console app to test SMTP functionality (i.e. simple sends)

So far, just 4 SMTP test functionalities (NOTE: only support for basic authentication)

1. Console application that uses a app settings and console input to initialise the .Net SmtpClient and send a MailMessage

2. SMTPTest.aspx - a simple page that uses form inputs to initialise the .Net SmtpClient and send a MailMessage

3. SitecoreSMTPTest.aspx - a simple page that uses form inputs to send a MailMessage through the MainUtil.SendMail

4. Powershell-SendMailMessageTest.ps1 - an example of Powershell's Send-MailMessage function (nothing special)
