import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Modelos.dart';

class Nodo extends CustomPainter{
  List<ModeloNodo> lista;
  Nodo(this.lista);
  @override
  void paint(Canvas canvas, Size size) {
   
    //canvas.drawCircle(Offset(100,200), 30, paint);
    Paint paint = new Paint()
    ..style= PaintingStyle.fill
    ..color = Colors.lime;
    for (int i=0;i<lista.length;i++){
      paint.color=lista[i].color;
      canvas.drawCircle(Offset(lista[i].x,lista[i].y), 30, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}
class Recta extends CustomPainter{
  List<ModeloNodo> listanodos;
  List<ModeloRecta> listrecta;
  Recta(this.listanodos,this.listrecta);
  @override
  void paint(Canvas canvas, Size size) {
   
    //canvas.drawCircle(Offset(100,200), 30, paint);
    Paint paint = new Paint()
    ..style= PaintingStyle.fill
    ..strokeWidth=5.0
    ..color = Colors.black;
    for (int i=0;i<listrecta.length;i++){
      canvas.drawLine(Offset(listanodos[listrecta[i].pos1].x,listanodos[listrecta[i].pos1].y),Offset(listanodos[listrecta[i].pos2].x,listanodos[listrecta[i].pos2].y) , paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}

