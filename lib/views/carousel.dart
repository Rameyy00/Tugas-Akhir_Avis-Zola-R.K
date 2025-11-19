// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class Mycarousel extends StatelessWidget {
//   const Mycarousel({super.key});

//   final List<String> imagerUrls = const [
//     'https://pbs.twimg.com/media/FtkTD4MaAAA7yL9.jpg',
//     'https://asset-2.tribunnews.com/jogja/foto/bank/images/Vivobook-Pro-14-OLED-Segera-Meluncur-Ini-Spesifikasinya.jpg',
//     'https://statik.tempo.co/data/2025/07/14/id_1412846/1412846_720.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Column(
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(
//               height: 200.0,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               viewportFraction: 0.8,
//             ),
//             items: imagerUrls.map((url) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.grey[200],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         url,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }