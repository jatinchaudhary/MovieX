import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSearchList extends StatelessWidget {
  const ShimmerSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[800]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey[900],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.grey[900],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: Colors.grey[900],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
