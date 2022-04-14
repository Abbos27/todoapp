import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() =>
    runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MyColorModel> colors = [
    MyColorModel(0xFF219653, MyColors.GREEN),
    MyColorModel(0xFFEB5757, MyColors.RED),
    MyColorModel(0xFFF2C94C, MyColors.YELLOW),
    MyColorModel(0xFF2F80ED, MyColors.BLUE),
    MyColorModel(0xFFF2994A, MyColors.ORANGE),
  ];
  MyColors? chosen_color_name;
  int? chosen_color;
  TextEditingController editController = TextEditingController();
  List<MyTask> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qaydnoma',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Color(0xFFFAFAFA),
        padding: EdgeInsets.fromLTRB(14, 6, 14, 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) =>
                        singleTaskRow(context, index),
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(colors.length, (index) {
                  var colorName = colors[index].colorName;
                  var color = colors[index].color;
                  return myRadioGroupItem(colorName, color);
                }),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: TextFormField(
                          controller: editController,
                          maxLines: 1,
                          // textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: 0,
                              top: 0,
                            ),
                            hintText: "Create a task",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF333333),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                addNewToDo(editController.text);
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget myRadioGroupItem(MyColors colorName, int color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          chosen_color_name = colorName;
          chosen_color = color;
        });
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(color),
          border: Border.all(
            color: chosen_color_name == colorName ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget singleTaskRow(BuildContext context, int index) {
    int selectedColor = tasks[index].color;
    String text = tasks[index].text;

    return Container(
      child: Card(
        elevation: 0,
        color: Color(0xFFEEEEEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 12),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Color(selectedColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(width: 22),
                    Expanded(child: Text(text)),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF6FB88E),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ), // Container
      ),
    );
  }

  void addNewToDo(String text) {
    if (chosen_color_name == null) {
      Fluttertoast.showToast(
          msg: "Rangni tanlang!",
          backgroundColor: Color(0xFFF44336),
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } else if (text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Textni kiriting!",
          backgroundColor: Color(0xFFF44336),
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      tasks.add(MyTask(chosen_color!, text));
      editController.clear();
    }
  }
}

class MyColorModel {
  int color;
  MyColors colorName;

  MyColorModel(this.color, this.colorName);
}

enum MyColors { GREEN, RED, YELLOW, BLUE, ORANGE }

class MyTask {
  int color;
  String text;

  MyTask(this.color, this.text);
}
