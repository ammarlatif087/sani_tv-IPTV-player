import 'package:http/http.dart' as http;

class Channel {
  String name;
  String link;

  Channel({required this.name, required this.link});
}

class M3UParser {
  static Future<List<Channel>> parseM3U(String m3uLink) async {
    final response = await http.get(Uri.parse(m3uLink));
    if (response.statusCode == 200) {
      final body = response.body;
      print(body);
      final List<Channel> channels = [];

      // Extract channel names and links from the M3U file
      final List<String> lines = body.split('\n');
      String currentName = '';
      String currentLink = '';
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.startsWith('#EXTINF:')) {
          // Extract the channel name from the #EXTINF: tag
          currentName = line.substring(line.indexOf(',') + 1).trim();
          if (i + 1 < lines.length) {
            // Extract the link from the next line if it contains "http"
            if (lines[i + 1].contains("http")) {
              currentLink = lines[i + 1].trim();
              channels.add(Channel(name: currentName, link: currentLink));
            }
          }
        }
      }

      return channels;
    } else {
      throw Exception('Failed to fetch M3U link');
    }
  }
}



// class M3UParser {
//   static Future<List<Channel>> parseM3U(String m3uLink) async {
//     final response = await http.get(Uri.parse(m3uLink));
//     if (response.statusCode == 200) {
//       final body = response.body;
//       print(body);
//       final List<Channel> channels = [];

//       // Extract channel names and links from the M3U file
//       final List<String> lines = body.split('\n');
//       String currentName = '';
//       String currentLink = '';
//       for (final line in lines) {
//         if (line.startsWith('#EXTINF:')) {
//           currentName = line.substring(line.indexOf(',') + 1).trim();
//         } else if (line.isNotEmpty) {
//           currentLink = line.trim();
//           channels.add(Channel(name: currentName, link: currentLink));
//         }
//       }

//       return channels;
//     } else {
//       throw Exception('Failed to fetch M3U link');
//     }
//   }
  // static Future<List<Channel>> parseM3U(String url) async {
  //   http.Response response = await http.get(Uri.parse(url));

  //   String fileContent = response.body;
  //   List<Channel> channels = [];

  //   // Split file content by lines
  //   List<String> lines = fileContent.split('\n');

  //   String channelName = "";
  //   String channelLink = "";

  //   for (String line in lines) {
  //     // Remove leading/trailing whitespaces
  //     line = line.trim();

  //     if (line.startsWith('#EXTINF:')) {
  //       // Parse channel name and link from #EXTINF line
  //       int commaIndex = line.indexOf(',');
  //       if (commaIndex != -1) {
  //         channelName = line.substring(commaIndex + 1).trim();
  //       }
  //     } else if (line.isNotEmpty) {
  //       // Parse channel link
  //       channelLink = line.trim();

  //       // Create channel object and add to list
  //       Channel channel = Channel(name: channelName, link: channelLink);
  //       channels.add(channel);

  //       // Reset channel name and link
  //       channelName = "";
  //       channelLink = "";
  //     }
  //   }

  //   return channels;
  // }
//}

// Usage: Call this from an async function

