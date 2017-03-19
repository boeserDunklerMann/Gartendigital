using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebServiceTest.Cons
{
	class Program
	{
		static void Main(string[] args)
		{
			Meereen.bookPortTypeClient raven = new Meereen.bookPortTypeClient();
			Meereen.getRavenResponsePortTypeClient resp = new Meereen.getRavenResponsePortTypeClient();
			string ret = raven.bookMsg("Hodor!");
			ret = resp.getRavenResponse(10);
			Console.WriteLine(ret);
		}
	}
}
