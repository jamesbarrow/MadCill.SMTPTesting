using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace JamesBarrow.SMTPTester
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var model = LoadModel(args);
                SmtpClient client = new SmtpClient(model.Host, model.Port);

                if (!string.IsNullOrEmpty(model.Username))
                {
                    client.UseDefaultCredentials = false;
                    client.Credentials = new NetworkCredential(model.Username, model.Password);
                }

                MailMessage message = new MailMessage()
                {
                    Body = model.Body,
                    Subject = model.Subject,
                    From = model.FromAddress,
                };
                message.To.Add(model.ToAddress);

                client.Send(message);
            }
            catch(SmtpException ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);

                if (ex.InnerException != null)
                {
                    Console.WriteLine(ex.InnerException);
                }

                if (ex.Data != null)
                {
                    foreach (var d in ex.Data)
                    {
                        Console.WriteLine(d);
                    }
                }
                
                Console.ReadKey();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);

                if (ex.InnerException != null)
                {
                    Console.WriteLine(ex.InnerException);
                }

                Console.ReadKey();
            }

            Console.WriteLine("Finished");
            Thread.Sleep(2000);
        }

        private static MailTestInputModel LoadModel(string[] args)
        {
            MailTestInputModel model = new MailTestInputModel();

            var input = GetValue("host", model.Host);
            if (!string.IsNullOrEmpty(input))
            {
                model.Host = input;
            }

            input = GetValue("port", model.Port.ToString());
            var intPort = 0;
            if (!string.IsNullOrEmpty(input) && int.TryParse(input, out intPort))
            {
                model.Port = intPort;
            }

            input = GetValue("username", model.Username);
            if (!string.IsNullOrEmpty(input))
            {
                model.Username = input;
            }

            input = GetValue("password", "****************");
            if (!string.IsNullOrEmpty(input))
            {
                model.Password = input;
            }

            input = GetValue("to address", model.To);
            if (!string.IsNullOrEmpty(input))
            {
                model.To = input;
            }

            input = GetValue("from address", model.From);
            if (!string.IsNullOrEmpty(input))
            {
                model.From = input;
            }

            input = GetValue("subject", model.Subject);
            if (!string.IsNullOrEmpty(input))
            {
                model.Subject = input;
            }

            input = GetValue("body", model.Body);
            if (!string.IsNullOrEmpty(input))
            {
                model.Body = input;
            }

            input = GetValue("'Y' if Body is HTML", "N");
            if (!string.IsNullOrEmpty(input))
            {
                model.IsHtml = input == "Y";
            }

            return model;
        }

        private static string GetValue(string field, string currentValue)
        {
            Console.WriteLine($"Enter {field} (current {currentValue}): ");
            return Console.ReadLine();
        }
    }
}
