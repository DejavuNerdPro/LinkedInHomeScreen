import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToShowHide extends StatefulWidget{

final Widget child;
final ScrollController controller;
final Duration duration;

  const ScrollToShowHide({super.key,required this.child,required this.controller,
  this.duration=const Duration(milliseconds: 200)
  });

  @override
  State<StatefulWidget> createState() =>ScrollToShowHideState();
  
}

class ScrollToShowHideState extends State<ScrollToShowHide>{
  bool isVisible=true;

  @override
  void initState(){
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  void dispose(){
    super.dispose();
  widget.controller.removeListener(listener);
    
  }

  void listener(){
    final direction=widget.controller.position.userScrollDirection;
    if(direction==ScrollDirection.forward){
      show();
    }else{
      hide();
    }
    // if(widget.controller.position.pixels >= 200){
    //   show();
    // }else{
    //   hide();
    // }
  }

  void show(){
    if(!isVisible) setState(() => isVisible=true,);
  }

  void hide(){
    if(isVisible) setState(() => isVisible=false,);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: widget.duration,
    height: isVisible? kBottomNavigationBarHeight:0,
    child: Wrap(children: [widget.child]),
  );

}