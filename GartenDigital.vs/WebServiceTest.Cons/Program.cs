using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace WebServiceTest.Cons
{
	class Program
	{
		static void Main(string[] args)
		{
			Meereen.bookPortTypeClient raven = new Meereen.bookPortTypeClient();
			Meereen.getRavenResponsePortTypeClient resp = new Meereen.getRavenResponsePortTypeClient();
			XmlDocument data = new XmlDocument();
			data.Load("Schema\\Raven.Beispiel.xml");
			string ret = raven.bookMsg(data.InnerXml);
			Console.WriteLine(ret);
			if (ret != "Hodor!")
			{
				// finde die ID zwischen den []
				int braceStart = ret.IndexOf('[');
				int braceEnd = ret.IndexOf(']');
				string strID = ret.Substring(braceStart + 1, braceEnd - braceStart - 1);
				int nID = 16;
				int.TryParse(strID, out nID);
				ret = resp.getRavenResponse(nID);
				Console.WriteLine(ret);
			}
		}
	}
}
