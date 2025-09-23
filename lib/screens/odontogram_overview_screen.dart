import 'package:flutter/material.dart';
import 'quadrant_detail_screen.dart';

enum Quadrant { upperLeft, upperRight, lowerLeft, lowerRight }

class OdontogramOverviewScreen extends StatelessWidget {
  const OdontogramOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tile(String title, String perm, String prim, Quadrant q) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuadrantDetailScreen(quadrant: q)),
          );
        },
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('영구치: $perm'),
                Text('유치: $prim'),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Odontogram 개요')),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        children: [
          // 화면 기준: 좌상 = 18..11 / 55..51
          tile('좌상(화면)', '18–11', '55–51', Quadrant.upperLeft),
          // 우상 = 21..28 / 61..65
          tile('우상(화면)', '21–28', '61–65', Quadrant.upperRight),
          // 좌하 = 48–41 / 85–81
          tile('좌하(화면)', '48–41', '85–81', Quadrant.lowerLeft),
          // 우하 = 31–38 / 71–75
          tile('우하(화면)', '31–38', '71–75', Quadrant.lowerRight),
        ],
      ),
    );
  }
}