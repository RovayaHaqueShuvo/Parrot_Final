import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final int itemCount;

  const CustomListView({super.key, this.itemCount = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height *
          0.1, // Height of the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            key: ValueKey(index),
            onTap: () {
              debugPrint('Tapped Item $index');
            },
            child: Column(
              children: [
                Container(
                  width:
                      MediaQuery.of(context).size.height *
                      0.07, // Make width same as height for circle
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/parrot.png'),
                ),
                Text(
                  'Parrot',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
