import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:flutter/material.dart';

class CircularProgressWithImage extends StatefulWidget {
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
  State<CircularProgressWithImage> createState() => _CircularProgressWithImageState();
}

class _CircularProgressWithImageState extends State<CircularProgressWithImage> {

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.imageSize + 15,
            height: widget.imageSize  + 15,
            child: CircularProgressIndicator(
              value: widget.progress,
              strokeWidth: widget.widghTela / 55,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Estabelecimento.primaryColor),
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: widget.imageSize,
              height: widget.imageSize,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}