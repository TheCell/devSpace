using System;

namespace StreamingCentral
{
    class Program
    {
        static void Main(string[] args)
        {
            //var server = new LocalServer();

            //server.Start();
            //var ytsearch = new YTSearchSample();
            //ytsearch.Start();

            var chatBot = new YTChatBot();
            chatBot.Start();
        }
    }
}
