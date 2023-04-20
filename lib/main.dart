import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_tv/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp(
          title: 'Free Tv ',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen()),
    );
  }
}

// class Examples extends StatefulWidget {
//   const Examples({Key? key}) : super(key: key);

//   @override
//   _ExamplesState createState() => _ExamplesState();
// }

// class _ExamplesState extends State<Examples> {
//   final List<Map<String, dynamic>> samples = [
//     // {'name': 'Default player', 'widget': DefaultPlayer()},
//     // {'name': 'Animation player', 'widget': Expanded(child: AnimationPlayer())},
//     // {'name': 'Feed player', 'widget': Expanded(child: FeedPlayer())},
//     {'name': 'Custom orientation player', 'widget': CustomOrientationPlayer()},
//     // {'name': 'Landscape player', 'widget': LandscapePlayer()},
//   ];

//   int selectedIndex = 0;

//   changeSample(int index) {
//     if (samples[index]['widget'] is LandscapePlayer) {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => LandscapePlayer(),
//       ));
//     } else {
//       setState(() {
//         selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildMobileView();
//   }

//   // Widget _buildWebView() {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.center,
//   //     children: <Widget>[
//   //       Expanded(child: WebVideoPlayer()),
//   //       Container(
//   //         child: Padding(
//   //           padding: const EdgeInsets.all(15.0),
//   //           child: Text('Flick video player',
//   //               style: TextStyle(
//   //                 color: Color.fromRGBO(100, 109, 236, 1),
//   //                 fontWeight: FontWeight.bold,
//   //               )),
//   //         ),
//   //       )
//   //     ],
//   //   );
//   // }

//   Widget _buildMobileView() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Container(
//           child: samples[selectedIndex]['widget'],
//         ),
//         Container(
//           height: 80,
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: samples.asMap().keys.map((index) {
//                 return Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       changeSample(index);
//                     },
//                     child: Center(
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text(
//                           samples.asMap()[index]?['name'],
//                           style: TextStyle(
//                             color: index == selectedIndex
//                                 ? Color.fromRGBO(100, 109, 236, 1)
//                                 : Color.fromRGBO(173, 176, 183, 1),
//                             fontWeight:
//                                 index == selectedIndex ? FontWeight.bold : null,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList()),
//         ),
//       ],
//     );
//   }
// }
