import 'dart:math';

import 'package:calc_fproj/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.dark, required this.tab, required this.switchThemes, required this.switchTab, required this.hist}) : super(key: key);
  bool dark;
  Function switchThemes;
  Function switchTab;
  int tab;
  List hist;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String val = "";
  bool f = true;
  @override
  void initState(){
    val = widget.hist.length!=0 ? widget.hist[widget.hist.length - 1] : "";
  }
  @override
  void update(){
    setState(() { widget.dark = widget.dark;
    });
  }
  @override
  void switchTheme() async{
    // print(dark);
    await widget.switchThemes();
    setState(() {
      widget.dark = !widget.dark;
    });
  }
  String compute() {
    String ans = "";
    double a = 0.0,
        b = 0.0;
    bool f2 = true;
    int d = 0;
    var map = new Map();
    List el = [];
    map[0] = [];
    map[1] = [];
    for (int j = 0; j < val.length; j++) {
      if (val[j] == '+' || val[j] == '-') {
        map[1].add(j);
        el.add(j);
      }

      if (val[j] == '×' || val[j] == '÷' || val[j] == '%') {
        map[0].add(j);
        el.add(j);
      }
    }
    try{

    for (int i = 0; i < map[0].length;) {
      int close1 = -1,
          close2 = val.length;
      for (int j = map[0][i] - 1; j >= 0; j--) {
        if (el.contains(j)) {
          close1 = j;
          break;
        }
      }
      for (int j = map[0][i] + 2; j < val.length; j++) {
        if (el.contains(j)) {
          close2 = j;
          break;
        }
      }
      f2 = true;
      //5+8-12+0.8*332-12
      print([close1, map[0][i]]);
      for (int j = close1 + 1; j < map[0][i]; j++) {
        if (val[j] == '.') {
          if (f2 == false) return "ERROR!";
          f2 = false;
          d = 0;
        }
        else {
          if (f2)
            a = a == 0 ? double.parse(val[j]) : a * 10 + double.parse(val[j]);
          else {
            d++;
            a += double.parse(val[j]) / pow(10, d);
          }
        }
      }
      f2 = true;
      print([map[0][i], close2]);
      for (int j = map[0][i] + 1; j < close2; j++) {
        if (val[j] == '.') {
          if (f2 == false) return "ERROR!";
          f2 = false;
          d = 0;
        }
        else if(val[j]!='-' && val[j]!='+'){
          if (f2)
            b = b == 0 ? double.parse(val[j]) : b * 10 + double.parse(val[j]);
          else {
            d++;
            b += double.parse(val[j]) / pow(10, d);
          }
        }
      }
      if(val[map[0][i]+1] == '-') {
        map[1].remove(map[0][i]+1);
        b*=-1;
      }
      else if(val[map[0][i]+1] == '+')
        map[1].remove(map[0][i]+1);

      if (val[map[0][i]] == '×')
        ans = (a * b).floor() == (a * b) ? "${(a * b).floor()}" : "${(a * b)}";
      else if (val[map[0][i]] == '÷'){
        if(b==0) {
          widget.hist.add('=ERROR!');
          return 'ERROR!';
        }
        ans = (a / b).floor() == (a / b) ? "${(a / b).floor()}" : "${(a / b)}";
      }
      else
        ans = (a % b).floor() == (a % b) ? "${(a % b).floor()}" : "${(a % b)}";

      for (int k = 0; k < el.length; k++) {
        if (val[el[k]] == val[map[0][i]]) {
          el.remove(el[k]);
          break;
        }
      }
      val = val.substring(0, close1 + 1) + ans +
          val.substring(close2, val.length);
      map[0].remove(map[0][i]);
      for (int k = 0; k < el.length; k++) {
        if (el[k] >= close2) el[k] -= close2 - close1 - 1 - ans.length;
      }
      for (int k = 0; k < map[0].length; k++) {
        if (map[0][k] >= close2) map[0][k] -= close2 - close1 - 1 - ans.length;
      }
      for (int k = 0; k < map[1].length; k++) {
        if (map[1][k] >= close2) map[1][k] -= close2 - close1 - 1 - ans.length;
      }

      a = 0;
      b = 0;
    }

    //7x5+6-9x8/5+6
    for (int i = 0; i < map[1].length;) {
      int close1 = -1,
          close2 = val.length;
      for (int j = map[1][i] - 1; j >= 0; j--) {
        if (el.contains(j)) {
          close1 = j;
          break;
        }
      }
      for (int j = map[1][i] + 2; j < val.length; j++) {
        if (el.contains(j)) {
          close2 = j;
          break;
        }
      }
      f2 = true;
      //5+8-12+0.8*332-12
      for (int j = close1 + 1; j < map[1][i]; j++) {
        if (val[j] == '.') {
          if (f2 == false) return "ERROR!";
          f2 = false;
          d = 0;
        }
        else if(val[j] == '-'){ a = -1*double.parse(val[j+1]); j++;}
        else {
          if (f2)
            a = a == 0 ? double.parse(val[j]) : a * 10 + double.parse(val[j]);
          else {
            d++;
            a = a + double.parse(val[j]) / pow(10, d);
          }
        }
      }
      f2 = true;
      for (int j = map[1][i] + 1; j < close2; j++) {
        if (val[j] == '.') {
          if (f2 == false){
            widget.hist.add('=ERROR!');
            return "ERROR!";
          }
          f2 = false;
          d = 0;
        }
        else if(val[j]!='-' && val[j]!='+'){
          if (f2)
            b = b == 0 ? double.parse(val[j]) : b * 10 + double.parse(val[j]);
          else {
            d++;
            b += double.parse(val[j]) / pow(10, d);
          }
        }
      }
      if(val[map[1][i]+1] == '-') b*=-1;
      if(val[map[1][i]+1] == '+') b*=1;

      if (val[map[1][i]] == '+')
        ans = (a + b).floor() == (a + b) ? "${(a + b).floor()}" : "${(a + b)}";
      else
        ans = (a - b).floor() == (a - b) ? "${(a - b).floor()}" : "${(a - b)}";

      for (int k = 0; k < el.length; k++) {
        if (val[el[k]] == val[map[1][i]]) {
          el.remove(el[k]);
          break;
        }
      }
      map[1].remove(map[1][i]);
      val = val.substring(0, close1 + 1) + ans +
          val.substring(close2, val.length);
      for (int k = 0; k < el.length; k++) {
        if (el[k] >= close2) el[k] -= close2 - close1 - 1 - ans.length;
      }
      for (int k = 0; k < map[0].length; k++) {
        if (map[0][k] >= close2) map[0][k] -= close2 - close1 - 1 - ans.length;
      }
      for (int k = 0; k < map[1].length; k++) {
        if (map[1][k] >= close2) map[1][k] -= close2 - close1 - 1 - ans.length;
      }
      a = 0;
      b = 0;
      print(el);
      print(map);
      print(val);
    }
    }
    catch(e){
      widget.hist.add('ERROR!');
      return "ERROR!";
    }
    setState(() {
      widget.hist.add("=" + ans);
    });
    return val;
  }
  //TODO : */
  //TODO : MediaQuery
  @override
  Widget build(BuildContext context) {
    // Color? bgColor = dark ? Colors.black54 : Colors.white70;
    // print(widget.tab);
    Widget ab = CustomAppBar(dark: widget.dark, switchTheme: switchTheme, tab: widget.tab, switchTab:widget.switchTab, update:update);
    return Scaffold(
      backgroundColor: widget.dark ? Color(0xFF181a1c) : Colors.white70,
      appBar: ab as PreferredSizeWidget?,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                    f && widget.hist.length >= 2? widget.hist[widget.hist.length-2] : "" as String,
                    style: TextStyle(
                      fontSize: 35.0,
                      color: widget.dark? Colors.white54 : Colors.black26,
                    ),
                ),Text(
                    f && widget.hist.length >= 2? widget.hist[widget.hist.length-1] : "" as String,
                    style: TextStyle(
                      fontSize: 35.0,
                      color: widget.dark? Colors.white54 : Colors.black26,
                    ),
                ),
                Text(
                    val != "" ? val : "0" as String,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: widget.dark? Colors.white : Colors.black,
                    ),
                ),
                Divider(
                  height:50.0,
                  thickness: 2.0,
                  color: widget.dark? Colors.white38 : Colors.black26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){setState(() {
                      val==""?f = false:null;
                      val = "";
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        elevation: 0
                      ),
                      child: Text(
                            val == "" ? "AC" : " C ",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.deepOrange)
                        ),
                    ),
                    ElevatedButton(onPressed: (){ if(val!='') setState(() {
                      val = val.substring(0, val.length-1);
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          elevation: 0
                      ),
                      child: Icon(
                          Icons.backspace_outlined,
                          color: Colors.deepOrange,
                      ),
                    ),
                    ElevatedButton(onPressed: (){if(val[val.length - 1] != '%')setState(() {
                      val = val!='ERROR!'? val+'%': '%';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "%",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    ),
                    ElevatedButton(onPressed: (){if(val == '' || val[val.length - 1] != '×')setState(() {
                      val = val!='ERROR!'? val == ""? val+"0÷" : val+'÷' : "0÷";
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "÷",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    )
                  ]
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'7': '%';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        elevation: 0
                      ),
                      child: Text(
                            " 7",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: widget.dark? Colors.white : Colors.black )
                        ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'8': '8';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          elevation: 0
                      ),
                        child: Text(
                            "  8",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: widget.dark? Colors.white : Colors.black )
                        ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'9': '9';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " 9",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){if(val == '' || val[val.length - 1] != '×')setState(() {
                      val = val!='ERROR!'? val == ""? val+"0×" : val+'×' : "0×";
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "×",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    )
                  ]
                ),
                SizedBox(height:15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'4': '4';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        elevation: 0
                      ),
                      child: Text(
                            " 4",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: widget.dark? Colors.white : Colors.black )
                        ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'5': '5';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          elevation: 0
                      ),
                      child: Text(
                          "  5",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'6': '6';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " 6",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){if(val == '' || val[val.length - 1] != '-')setState(() {
                      val = val!='ERROR!'? val == ""? val+"0-" : val+'-' : "0-";
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "-",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    )
                  ]
                ),
                SizedBox(height:15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'1': '1';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " 1",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'2': '2';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          elevation: 0
                      ),
                      child: Text(
                          "  2",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'3': '3';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " 3",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),
                    ElevatedButton(onPressed: (){if(val == '' || val[val.length - 1] != '+')setState(() {
                      val = val!='ERROR!'? val == ""? val +"0+" : val+'+' : "0+";
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "+",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    )
                  ]
                ),
                SizedBox(height:15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){null;},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        elevation: 0
                      ),
                      child: Text(
                            " ",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.deepOrange)
                        ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val = val!='ERROR!'? val+'0': '0';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " 0",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),

                    ElevatedButton(onPressed: (){if(val[val.length - 1] != '.')setState(() {
                      val = val!='ERROR!'? val+'.': '0.';
                    });},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          " .",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: widget.dark? Colors.white : Colors.black )
                      ),
                    ),

                    ElevatedButton(onPressed: (){setState(() {
                      f = true;
                      widget.hist.add(val);
                      val = compute();
                    });},
                      style: ElevatedButton.styleFrom(
                          // primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          primary: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0,
                      ),
                      child: Text(
                          "=",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white)
                      ),
                    )
                  ]
                ),
                SizedBox(height:10.0),

              ],
            ),
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
