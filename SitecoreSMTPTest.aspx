<%@ Page Language="C#" AutoEventWireup="true" EnableSessionState="False" EnableViewState="False" EnableViewStateMac="False" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sitecore SMTP Test</title>
    <style>
        span {
            width: 100px;
            margin-right: 100px;
            display: inline-block;
        }

        div {
            padding-bottom: 15px;
        }

        #divHeaderDump {
            color: red;
        }
    </style>
</head>
<body>
    <form id="formHeaderDump" runat="server">
        <div id="divHeaderDump">
            <asp:Literal ID="litrlHeaderDump" runat="server" Text="Utilising the MailUtil.SendMail functionality and settings" />
        </div>
        <div>
            <span>Subject:</span>
            <asp:TextBox ID="tbSubject" runat="server" Text="This is a test email subject" />
        </div>
        <div>
            <span>Body:</span>
            <asp:TextBox ID="tbBody" runat="server" Text="This is a test email body" />
        </div>
        <div>
            <span>From:</span>
            <asp:TextBox ID="tbFrom" runat="server" Text="someemailfrom@testmailhost.com" />
        </div>
        <div>
            <span>To:</span>
            <asp:TextBox ID="tbTo" runat="server" Text="someemailto@testmailhost.com" />
        </div>
        <div>
            <asp:Button ID="btnSend" OnClick="Send_Email" Text="Send" runat="server" />
        </div>
    </form>
</body>
</html>
<script runat="server">
    void Page_Load(object sender, EventArgs e)
    {
    }
    void Send_Email(object sender, EventArgs e)
    {
        try
        {

            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
            message.Body = tbBody.Text;
            message.Subject = tbSubject.Text;

            message.Body += " - message sent at: " + System.DateTime.Now.ToString();

            if (!string.IsNullOrEmpty(tbTo.Text))
            {
                message.To.Add(new System.Net.Mail.MailAddress(tbTo.Text));
            }

            if (!string.IsNullOrEmpty(tbFrom.Text))
            {
                message.From = new System.Net.Mail.MailAddress(tbFrom.Text);
            }

            Sitecore.MainUtil.SendMail(message);

            litrlHeaderDump.Text = "Message sent";
        }
        catch (System.Net.Mail.SmtpException ex)
        {
            litrlHeaderDump.Text = "SMTP Exception thrown: " + ex.Message + " - " + ex.StackTrace;

            if (ex.InnerException != null)
            {
                litrlHeaderDump.Text += " - " + ex.InnerException.Message + " - " + ex.InnerException.StackTrace;
            }

            if (ex.Data != null)
            {
                foreach (string d in ex.Data)
                {
                    litrlHeaderDump.Text += " - " + d;
                }
            }
        }
        catch (System.Exception ex)
        {
            litrlHeaderDump.Text = "Exception thrown: " + ex.Message + " - " + ex.StackTrace;
        }
    }
</script>
