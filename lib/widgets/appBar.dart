import 'package:flutter/material.dart';
import '../home.dart';
import '../history.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key, required this.dark, required this.switchTheme, required this.tab, required this.switchTab, required this.update}) : preferredSize = Size.fromHeight(50.0), super(key: key);
  bool dark;
  int tab;
  final Function switchTheme;
  final Function switchTab;
  final Size preferredSize;
  final Function update;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    // bool dark;
    return AppBar(
      // backgroundColor: widget.dark ?Color(0xFF181a1c) : Colors.white70,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
            IconButton(
                // disabledColor: Colors.white24,
                onPressed: () async {
                  if(widget.tab == 1) {
                    setState(() {
                      widget.tab = 0;
                      widget.switchTab(0);
                    });
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) => Home(tab:widget.tab, switchTab: widget.switchTab, switchThemes: widget.switchTheme, dark: widget.dark,),
                    // ),);
                    await widget.update();
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, '/');
                  }
                },
                icon: Icon(
                    Icons.calculate,
                    color: widget.tab == 0? Colors.deepOrange : widget.dark? Colors.white54 : Colors.black54
                ),
            ),
            SizedBox(width: MediaQuery. of(context). size. width/5),
            IconButton(
                onPressed: () async {
                  if(widget.tab ==  0){
                    setState(() {
                      widget.tab = 1;
                      widget.switchTab(1);
                    });
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) => Home(tab:widget.tab, switchTab: widget.switchTab, switchThemes: widget.switchTheme, dark: widget.dark,),
                    // ),).then((_) => setState(() {}));
                    Navigator.pushNamed(context, '/history').then( widget.update());
                  }
                },
                icon: Icon(
                    Icons.history,
                    color: widget.tab == 1? Colors.deepOrange : widget.dark? Colors.white54 : Colors.black54
                )
            ),
            SizedBox(width: MediaQuery. of(context). size. width/5),
            IconButton(
                // onPressed: () {widget.switchTheme();},
                onPressed: () {setState(() {
                  widget.dark = !widget.dark;
                  widget.switchTheme();
                  // initState();
                });},

                icon: Icon(
                    widget.dark ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.deepOrange
                )
            ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: MediaQuery. of(context). size. width/5),
          ],
        ),
      ],
    );
  }
}
