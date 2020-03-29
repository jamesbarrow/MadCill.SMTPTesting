<%@ Page Language="C#" AutoEventWireup="true" EnableSessionState="False" EnableViewState="False" EnableViewStateMac="False" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SMTP Test</title>
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
            <asp:Literal ID="litrlHeaderDump" runat="server" />
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
            <span>Host:</span>
            <asp:TextBox ID="tbHost" runat="server" Text="localhost" />
        </div>
        <div>
            <span>Port:</span>
            <asp:TextBox ID="tbPort" runat="server" Text="25" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                ControlToValidate="tbPort" runat="server"
                ErrorMessage="Only Numbers allowed"
                ValidationExpression="\d(4)">
            </asp:RegularExpressionValidator>
        </div>
        <div>
            <span>If username is blank then no basic authentication used</span>
            <span>Username:</span>
            <asp:TextBox ID="tbUsername" runat="server" Text="" />
        </div>
        <div>
            <span>Password:</span>
            <asp:TextBox TextMode="Password" ID="tbPassword" runat="server" />
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
            int port = int.Parse(tbPort.Text);
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient(tbHost.Text, port);

            if (!string.IsNullOrEmpty(tbUsername.Text))
            {
                client.UseDefaultCredentials = false;
                client.Credentials = new System.Net.NetworkCredential(tbUsername.Text, tbPassword.Text);
            }

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

            //clear this each time
            tbPassword.Text = "";

            client.Send(message);

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
