import 'package:barbershop2/classes/cortecClass.dart';

class GeralUser {

  final String name;
  final String urlImage;
  final int listacortes;
  final bool isManager;

  GeralUser({
 
    required this.isManager,
    required this.listacortes,
    required this.name,
    required this.urlImage,
  });
}
