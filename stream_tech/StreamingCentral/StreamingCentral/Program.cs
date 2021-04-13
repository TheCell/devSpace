using System;

namespace StreamingCentral
{
    class Program
    {
        static void Main(string[] args)
        {
            LocalServer server = new LocalServer();

            server.Start();
        }
    }
}
