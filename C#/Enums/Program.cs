using System;
using System.Collections.Generic;
using Enums.Enums;
using Enums.Model;
//using Enums.Enums;
namespace Enums
{
    class Program
    {
        static void Main(string[] args)
        {
            Program.init();
        }

        private static void init()
        {
            List<Student> st = new List<Student>();
            st.Add(new Student
            {
                Id = 1,
                Name = "Puneeth N",
                Gender = Enums.Gender.Male

            });
            st.Add(new Student
            {
                Id = 2,
                Name = "Bhagya K",
                Gender = Enums.Gender.Female

            });
            st.Add(new Student
            {
                Id = 3,
                Name = "Latha K",
                Gender = Enums.Gender.Female

            });

            foreach (var item in st)
            {
                Console.WriteLine("{0,10},{1,10},{2,10 }",item.Id,item.Name,item.Gender);
               
            }
            Console.WriteLine("*************************************************************");
            short[] values =(short[])Enum.GetValues(typeof(Gender));
            foreach (var item in values)
            {
                Console.WriteLine(item);
            }
            Console.WriteLine("*************************************************************");
            string[] Names =Enum.GetNames(typeof(Gender));
            foreach (var item in Names)
            {
                Console.WriteLine(item);
            }
            Console.WriteLine("*************************************************************");
        }
    }
}
