import 'dart:math';

import 'package:flutter/material.dart';

import 'Figuras.dart';
import 'Modelos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Puente(),
    );
  }
}
class Puente extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Grafo();
  }
  
}
class Grafo extends State<Puente>{
  bool flagAC=true, flagMOV =false,flagUNIR = false,flagDEL=false,flagCA = false;
  List <ModeloNodo>listanodos=List();
  List<ModeloRecta>listarectas=List();
  var gr= Random();
double x,y;
int modo=0;
int momentoNodo=0;
int posInicio=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grafos'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle,color: flagAC ? Colors.green:Colors.white,),
          onPressed: (){
            setState(() {
              flagAC =true;
              flagMOV =false;
              flagUNIR = false;
              flagDEL=false;
              flagCA = false;
              modo=0;
            }); 
          },
        ),
        IconButton(
          icon:Icon(Icons.call_to_action, color:flagMOV ? Colors.green:Colors.white),
          onPressed: (){
            setState(() {
                 flagAC =false;
              flagMOV =true;
              flagUNIR = false;
              flagDEL=false;
              flagCA = false;
              modo=1;
            });
           
              
          },),
          IconButton(icon: Icon(Icons.dialpad, color:flagUNIR ? Colors.green:Colors.white),
            onPressed: (){
              setState(() {
                   flagAC =false;
              flagMOV =false;
              flagUNIR = true;
              flagDEL=false;
              flagCA = false;
              modo=2;
              momentoNodo=0;
              });
              
            },),
          IconButton(icon: Icon(Icons.clear,color:flagDEL ? Colors.green:Colors.white),
          onPressed: (){
            setState(() {
                 flagAC =false;
              flagMOV =false;
              flagUNIR = false;
              flagDEL=true;
              flagCA = false;
              modo=3;
            });

          },),
           IconButton(icon: Icon(Icons.clear_all,color:flagCA ? Colors.green:Colors.white),
          onPressed: (){
              setState(() {
                   flagAC =false;
              flagMOV =false;
              flagUNIR = false;
              flagDEL=false;
              flagCA = true;
              modo=4;
              });
          },) 
      ],
      ),
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: Recta(listanodos, listarectas),
            child: Container(

            )
          ),
          CustomPaint(
            painter: Nodo(listanodos),
            child: Container(
              child: GestureDetector(
                onTapDown: (details){
                 setState(() {
                   switch (modo){
                     case 0:
                     x=details.globalPosition.dx;
                   y= details.globalPosition.dy-75;
                   listanodos.add(ModeloNodo(x, y, Color.fromRGBO(gr.nextInt(255), gr.nextInt(255), gr.nextInt(255), 1)));
                    break;
                     case 2:
                      int pos = inside(details.globalPosition.dx, details.globalPosition.dy-75);
                      if(pos>=0){
                          if(momentoNodo==0){
                            posInicio=pos;
                            momentoNodo=1;
                          }
                          else{
                            if(posInicio!=pos){
                              listarectas.add(ModeloRecta(posInicio,pos));
                            }
                            momentoNodo=0;
                          }
                        
                      }
                    break;
                     case 3:
                      int pos=inside(details.globalPosition.dx,details.globalPosition.dy-75);
                      if (pos>=0)
                      {
                        listanodos.removeAt(pos);
                        
                      }
                    break;
                     case 4:
                     listanodos.clear();
                    break;
                   }
                   
                 });
                },
                onPanUpdate: (d){
                  setState(() {
                    if (modo==1){
                      int pos = inside(d.globalPosition.dx, d.globalPosition.dy-75);
                      if(pos>=0){
                        listanodos[pos].x=d.globalPosition.dx;
                        listanodos[pos].y=d.globalPosition.dy-75;
                      }
                    }
                  });
                },
              ),
            )
          )
        ],
      ),
    
    );
  }
  int inside(x,y){
    int pos=-1;
    double radio=30;
    for(int i=0;i<listanodos.length;i++){
      double xc =listanodos[i].x-radio;
      double yc=listanodos[i].x-radio;
      double wc = listanodos[i].x+radio;
      double hc = listanodos[i].y+radio;
      if((x>=xc && x<=wc)&&(y>=yc && y<=hc)){
        pos=i;
      }
    }
    return pos;
  }
}