import 'package:flutter/material.dart';
import 'package:calc_fproj/widgets/appBar.dart';
import 'package:google_fonts/google_fonts.dart';
class History extends StatefulWidget {
  History({Key? key, required this. dark, required this.tab, required this.switchThemes, required this.switchTab, required this.hist}) : super(key: key);
  bool dark;
  int tab;
  Function switchThemes;
  Function switchTab;
  List hist;
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void switchTheme() async {
    await widget.switchThemes();
    setState(() {
      widget.dark = !widget.dark;
    });
  }
  @override
  void update(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    // Color? bgColor = dark ? Colors.black54 : Colors.white70;
    // print(widget.tab);
    Widget ab = CustomAppBar(dark: widget.dark, switchTheme: switchTheme, tab: widget.tab, switchTab: widget.switchTab, update:update);
    return Scaffold(
      backgroundColor: widget.dark ? Color(0xFF181a1c) : Colors.white70,
      appBar: ab as PreferredSizeWidget?,
      body: (
              ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: widget.hist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
                        child: Text(
                            widget.hist[index].toString(),
                            style: GoogleFonts.oswald(
                              fontSize: 40.0,
                              color: widget.dark?Colors.white:Colors.black,)
                        ),
                      ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
      )
    );
  }
}
