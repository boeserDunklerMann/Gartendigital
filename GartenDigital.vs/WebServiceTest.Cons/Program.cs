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
			Mereen.bookPortTypeClient raven = new Mereen.bookPortTypeClient();
			Mereen.getRavenResponsePortTypeClient resp = new Mereen.getRavenResponsePortTypeClient();
			string ret = raven.bookMsg("Hodor!");
			ret = resp.getRavenResponse(10);
			Console.WriteLine(ret);
		}
	}
}
