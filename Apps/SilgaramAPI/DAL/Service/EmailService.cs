using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using System.Net;
using System.Net.Mail;
using DAL.Resource;
using System.Web;
using DAL.Models.ViewModel;

namespace DAL.Service
{
    public class EmailService 
    {


        public static void SendEmail(string toEmail, string alisName, string subjec, string message, bool isHtml)
        {

            var smtp = new SmtpClient(WCMVM.HostMail);
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential(WCMVM.BaseEmail, WCMVM.BaseEmailPassword);


            MailMessage msg = new MailMessage();
            msg.From = new MailAddress(WCMVM.BaseEmail, Token.ApplicationName);
            msg.To.Add(new MailAddress(toEmail));
            msg.Subject = subjec;
            msg.BodyEncoding = Encoding.UTF8;
            msg.IsBodyHtml = isHtml;
            msg.Body = message;
            smtp.Send(msg);
            msg.Dispose();
        }



        public static void SendPassword(string email, string userName, string pass)
        {
            string Mess = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("/Files/Document/ForgetPassword.html"));
            string CssFileName = LanguageService.IsEn ? "ForgetPasswordStyleEn.css" : "ForgetPasswordStyleAr.css";
            string Css = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("/Content/" + CssFileName));


            var Message = string.Format(Mess,
                Css, Token.Dear, userName, Token.YourPasswordIs, pass.ToString());
            SendEmail(email, Token.ApplicationName, Token.ApplicationName + " - " + Token.AcctiveAccount, Message, true);
        }

    }
}
