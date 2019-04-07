using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace DAL.Service
{
   public class XMLService
    {
        public static void WritrInXmlFile(string ElementName, string Value)
        {
            string serverpath = System.Web.HttpContext.Current.Server.MapPath("~/Files/Document/");
            XmlDocument dco = new XmlDocument();
            dco.Load(serverpath + "ApplicationConfig.xml");
            XmlNodeList xmlList = dco.GetElementsByTagName(ElementName);
            xmlList[0].InnerXml = Value;
            dco.Save(serverpath + "ApplicationConfig.xml");
        }

        public static string ReadInXmlFile(string ElementName)
        {
            XmlDocument dco = new XmlDocument();
            string serverpath = System.Web.HttpContext.Current.Server.MapPath("~/Files/Document/");
            dco.Load(serverpath + "ApplicationConfig.xml");
            XmlNodeList xmlList = dco.GetElementsByTagName(ElementName);
            return xmlList[0].InnerText;
        }

    }
}
