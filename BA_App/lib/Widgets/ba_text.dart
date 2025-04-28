import 'package:flutter/material.dart';

class BACardText extends StatelessWidget {
  final String vendor;
  final String location;
  final String discount;
  // final double Top;
  // final double Left;

  const BACardText({
    super.key,
    required this.vendor,
    required this.location,
    required this.discount,
    // required this.Top,
    // required this.Left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Vendor:', vendor),
          _buildLocationRow(location),
          _buildInfoRow('Discount:', discount),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    if (value == '20% Gold, 60%\nDiamonds') {
      final lines = value.split('\n');
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discount:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    lines[0], // Display the first line in the same row
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (lines.length > 1) // If there are additional lines
              Padding(
                padding: const EdgeInsets.only(left: 0), // Indent for alignment
                child: Text(
                  lines
                      .sublist(1)
                      .join('\n'), // Join and display remaining lines
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500),
                ),
              ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(width: 5.0),
          Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String location) {
    // Split location into multiple lines
    final lines = location.split('\n');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Location:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  lines[0], // Display the first line in the same row
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (lines.length > 1) // If there are additional lines
            Padding(
              padding: const EdgeInsets.only(left: 0), // Indent for alignment
              child: Text(
                lines.sublist(1).join('\n'), // Join and display remaining lines
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }

  // Widget _buildLocationRow(String location) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8.0),
  //     child: Row(
  //       children: [
  //         const Text(
  //           'Location:',
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
  //         ),
  //         const SizedBox(width: 8.0),
  //         Expanded(
  //           child: Flexible(
  //             child: Text(
  //               style: TextStyle(fontSize: 12),
  //               location,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
