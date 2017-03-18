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
			ServiceReference1.addPortTypeClient test = new ServiceReference1.addPortTypeClient();
			int x = test.add(3, 5);
			
		}
	}
}
