import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:flutter/material.dart';

class CircularProgressWithImage extends StatelessWidget {
  final double progress;
  final String imageUrl;
  final double imageSize;
  final double widghTela;

  CircularProgressWithImage({
    required this.progress,
    required this.imageUrl,
    required this.widghTela,
    this.imageSize = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: imageSize + 15,
            height: imageSize  + 15,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: widghTela / 55,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Estabelecimento.primaryColor),
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: imageSize,
              height: imageSize,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}