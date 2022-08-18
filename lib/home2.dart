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
  @override
  void initState(){
    val = widget.hist.length!=0 ? widget.hist[widget.hist.length - 1] : "";
  }
  @override
  void update(){
    print("updating");
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
  String compute(){
    String ans = "";
    double a = 0.0, b = 0.0;
    bool f = true, f2 = true;
    int d = 0;
    for(int i = 0;i<val.length;i++){
      if(val[i] == '+') {
        int j;
        f2 = true;
        for(j = i+1;j<val.length;j++){
          if(val[j] == '+' || val[j] == '-' || val[j] == '×' || val[j] == '÷' || val[j] == '%'){
            ans = (a+b).floor() == (a+b) ? "${(a+b).floor()}" : "${(a+b)}";
            a = a+b;
            b = 0;
            f2=true;
            break;
          }
          else if(val[j] == '.') {
            f2 = false;
            d=0;
          }
          else{
            if(f2) b = b==0 ? double.parse(val[j]) : b*10 + double.parse(val[j]);
            else  {
              d++;
              b = b== 0 ? double.parse(val[j]) : b + double.parse(val[j])/pow(10,d);
            }
          }
        }
        if(j == val.length)   ans = (a+b).floor() == (a+b) ? "${(a+b).floor()}" : "${(a+b)}";
        i=j-1;
      }
      else if(val[i] == '-'){
        int j;
        f2 = true;
        for(j = i+1;j<val.length;j++){
          if(val[j] == '+' || val[j] == '-' || val[j] == '×' || val[j] == '÷' || val[j] == '%'){
            ans = (a-b).floor() == (a-b) ? "${(a-b).floor()}" : "${(a-b)}";
            a = a-b;
            b = 0;
            f2=true;
            break;
          }
          else if(val[j] == '.') {
            f2 = false;
            d=0;
          }
          else{
            if(f2) b = b==0 ? double.parse(val[j]) : b*10 + double.parse(val[j]);
            else  {
              d++;
              b = b== 0 ? double.parse(val[j]) : b + double.parse(val[j])/pow(10,d);
            }
          }
        }
        if(j == val.length)   ans = (a-b).floor() == (a-b) ? "${(a-b).floor()}" : "${(a-b)}";
        i=j-1;
      }
      else if(val[i] == '×') {
        int j;
        f2 = true;
        for(j = i+1;j<val.length;j++){
          if(val[j] == '+' || val[j] == '-' || val[j] == '×' || val[j] == '÷' || val[j] == '%'){
            ans = (a*b).floor() == (a*b) ? "${(a*b).floor()}" : "${(a*b)}";
            a = a*b;
            b = 0;
            f2=true;
            break;
          }
          else if(val[j] == '.') {
            f2 = false;
            d=0;
          }
          else{
            if(f2) b = b==0 ? double.parse(val[j]) : b*10 + double.parse(val[j]);
            else  {
              d++;
              b = b== 0 ? double.parse(val[j]) : b + double.parse(val[j])/pow(10,d);
            }
          }
        }
        if(j == val.length)   ans = (a*b).floor() == (a*b) ? "${(a*b).floor()}" : "${(a*b)}";
        i=j-1;
        print(b);
      }
      else if(val[i] == '÷'){
        int j;
        f2 = true;
        for(j = i+1;j<val.length;j++){
          if(val[j] == '+' || val[j] == '-' || val[j] == '×' || val[j] == '÷' || val[j] == '%'){
            ans = (a/b).floor() == (a/b) ? "${(a/b).floor()}" : "${(a/b)}";
            a = a/b;
            b = 0;
            f2=true;
            break;
          }
          else if(val[j] == '.') {
            f2 = false;
            d=0;
          }
          else{
            if(f2) b = b==0 ? double.parse(val[j]) : b*10 + double.parse(val[j]);
            else  {
              d++;
              b = b== 0 ? double.parse(val[j]) : b + double.parse(val[j])/pow(10,d);
            }
          }
        }
        if(j == val.length)   ans = (a/b).floor() == (a/b) ? "${(a/b).floor()}" : "${(a/b)}";
        i=j-1;
      }
      else if(val[i] == '%'){
        int j;
        f2 = true;
        for(j = i+1;j<val.length;j++){
          if(val[j] == '+' || val[j] == '-' || val[j] == '×' || val[j] == '÷' || val[j] == '%'){
            ans = (a%b).floor() == (a%b) ? "${(a%b).floor()}" : "${(a%b)}";
            a = a%b;
            b = 0;
            f2=true;
            break;
          }
          else if(val[j] == '.') {
            f2 = false;
            d=0;
          }
          else{
            if(f2) b = b==0 ? double.parse(val[j]) : b*10 + double.parse(val[j]);
            else  {
              d++;
              b = b== 0 ? double.parse(val[j]) : b + double.parse(val[j])/pow(10,d);
            }
          }
        }
        if(j == val.length)   ans = (a%b).floor() == (a%b) ? "${(a%b).floor()}" : "${(a%b)}";
        i=j-1;
      }
      else if(val[i] == '.'){
        f2 =false;
        d = 0;
      }

      else{
        if(f2)a = a==0 ? double.parse(val[i]) : a*10 + double.parse(val[i]);
        else {
          d++;
          a = a == 0 ? double.parse(val[i]) : a + double.parse(val[i])/pow(10,d);
        }
      }
    }
    setState(() {
      widget.hist.add(val);
    });
    return ans;
  }
  //TODO : */
  //TODO : MediaQuery
  @override
  Widget build(BuildContext context) {
    // Color? bgColor = dark ? Colors.black54 : Colors.white70;
    // print(widget.tab);
    Widget ab = CustomAppBar(dark: widget.dark, switchTheme: switchTheme, tab: widget.tab, switchTab:widget.switchTab, update: update);
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
                      val += '%';
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
                      val += val == ""? "0÷" : '÷';
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
                      val += '7';
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
                      val += '8';
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
                      val += '9';
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
                      val += val == ""? "0×" : '×';
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
                      val += '4';
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
                      val += '5';
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
                      val += '6';
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
                      val += val == ""? "0-" : '-';
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
                      val += '1';
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
                      val += '2';
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
                      val += '3';
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
                      val += val == ""? "0+" : '+';
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
                    ElevatedButton(onPressed: (){val = "0";},
                      style: ElevatedButton.styleFrom(
                          primary: widget.dark ? Color(0xFF181a1c) : Colors.white70,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          elevation: 0
                      ),
                      child: Text(
                          "AC",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.deepOrange)
                      ),
                    ),
                    ElevatedButton(onPressed: (){setState(() {
                      val += '0';
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
                      val += '.';
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
