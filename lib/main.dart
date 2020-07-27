
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:roundcheckbox/roundcheckbox.dart';



void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: ('ToDo'),
      color: Colors.blue,
      home:  HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final  List<String> _todoItems=[];
  void _addTodoItem(String task ) {

    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }
  void _pushAddTodoScreen() {

    Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                backgroundColor: Colors.white,

                  appBar: new AppBar(
                    backgroundColor: Colors.indigo[500],
                    centerTitle: true,

                      title: new Text('Add a new task',style: TextStyle(color: Colors.white),),

                  ),
                  body: new TextField(

                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(

                      icon: Icon(Icons.note_add),
                        hintText: ('Enter something to do...'),

                        contentPadding: const EdgeInsets.all(16.0)
                    ),

                  )
              );
            }
        )
    );
  }


  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {

        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }

        return Text('No slide availabe.');
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return new ListTile(
        title: new Text(todoText)
    );
  }

  bool selected=true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body:Stack(children: <Widget>[
    Column(children: <Widget>[

      Center(
        child: Image(image: NetworkImage('https://s3.amazonaws.com/user-media.venngage.com/1006002-e09cc2867af047669dccb5a8e6f47486.png'),fit: BoxFit.cover,),
      ),
      Center(child:

      FlutterAnalogClock(

        dateTime: DateTime.now(),
        dialPlateColor: Colors.white,
        hourHandColor: Colors.black,
        minuteHandColor: Colors.black,
        secondHandColor: Colors.grey[700],
        numberColor: Colors.black,
        borderColor: Colors.indigoAccent,
        tickColor: Colors.black,
        centerPointColor: Colors.black,

        showBorder: true,
        showTicks: true,
        showMinuteHand: true,
        showSecondHand: true,
        showNumber: true,
        borderWidth: 8.0,
        hourNumberScale: .10,

        isLive: true,
        width: 130.0,
        height: 130.0,

      )
      ),
    ]
      ),

        Positioned(
          child: Text("Todo", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
          top: 40,
          left: 20,
        ),

        DraggableScrollableSheet(
          maxChildSize: 0.85,
          minChildSize: 0.1,
          builder: (BuildContext context, ScrollController scrolController){
            return Stack(
              overflow: Overflow.visible,
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                  ),
                  child: ListView.builder(
    itemCount: _todoItems.length,
    itemBuilder: (context, index) {
    final item =_todoItems[index];
                      return  Dismissible(

                          key: Key(item),

                      onDismissed: (direction) {

                      setState(() {
      _todoItems.removeAt(index);
                      });


                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text("Task Successfully dismissed")));
                      },

                      background: Container(color: Colors.red,),
                      child: ListTile(
                        title: Text("${_todoItems[index]}", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                        subtitle: Text(" This is your task no. $index", style: TextStyle(color: Colors.grey[700]),),
                        trailing: RoundCheckBox(
                            onTap: (selected) {}
                        ),
                        isThreeLine: true,
                      )
                      );
                    },
                    controller: scrolController,

                  ),
                ),

                Positioned(
                  child: FloatingActionButton(

                    child: Icon(Icons.add, color: Colors.white,),
                    backgroundColor: Colors.blue,
                    onPressed: _pushAddTodoScreen,
                    tooltip: 'Add task',
                  ),
                  top: -30,
                  right: 30,
                )

              ],
            );
          },
        )

      ],
      ),
    );
  }
}
