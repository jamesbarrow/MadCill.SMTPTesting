using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace JamesBarrow.SMTPTester
{
    public class MailTestInputModel
    {
        public MailTestInputModel()
        {
            Host = ConfigurationManager.AppSettings["Default_Host"];
            int port = 25;
            if(int.TryParse(ConfigurationManager.AppSettings["Default_Port"], out port))
            {
                Port = port;
            }
            To = ConfigurationManager.AppSettings["Default_ToAddress"];
            From = ConfigurationManager.AppSettings["Default_FromAddress"];
            _subject = ConfigurationManager.AppSettings["Default_Subject"];
            _body = ConfigurationManager.AppSettings["Default_Body"];
            IsHtml = ConfigurationManager.AppSettings["Default_IsBodyHtml"] == "true";

            Username = ConfigurationManager.AppSettings["Default_Username"];
            Password = ConfigurationManager.AppSettings["Default_Password"];
        }
        public string Host { get; set; }

        public int Port { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public string To { get; set; }

        public string From { get; set; }

        public MailAddress ToAddress { 
            get
            {
                if (!string.IsNullOrEmpty(To))
                {
                    return new MailAddress(To);
                }
                throw new MissingFieldException("To address not set");
            }
        }

        public MailAddress FromAddress {
            get
            {
                if (!string.IsNullOrEmpty(From))
                {
                    return new MailAddress(From);
                }
                throw new MissingFieldException("From address not set");
            }
        }

        private string _subject;
        public string Subject { get
            {
                return _subject?.Replace("{date}", DateTime.Now.ToString());
            }
            set
            {
                _subject = value;
            }
        }

        private string _body;
        public string Body
        {
            get
            {
                return _body?.Replace("{date}", DateTime.Now.ToString());
            }
            set
            {
                _body = value;
            }
        }

        public bool IsHtml { get; set; }
    }
}
