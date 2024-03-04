import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int winner=0;
  List<List<int>> matrix_table =[[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
  int turn=1;
  int state=0; //put 0 rotate 1 finish -1


  List<List<List<List<int>>>> convertT2S(List<List<int>> table){
    List<List<List<List<int>>>> squares=[[],[]];
    
    List<List<int>> square=[];
    for (var i = 0; i < 3; i++){
      List<int> tempRow=[];
      for (var j = 0; j < 3; j++){
        tempRow.add(table[i][j]);
      }
      square.add(tempRow);
    }
    squares[0].add(square);
    square=[];
    for (var i = 0; i < 3; i++){
      List<int> tempRow=[];
      for (var j = 3; j < 6; j++){
        tempRow.add(table[i][j]);
      }
      square.add(tempRow);
    }
    squares[0].add(square);
    square=[];
    for (var i = 3; i < 6; i++){
      List<int> tempRow=[];
      for (var j = 0; j < 3; j++){
        tempRow.add(table[i][j]);
      }
      square.add(tempRow);
    }
    
    squares[1].add(square);
    square=[];
    for (var i = 3; i < 6; i++){
      List<int> tempRow=[];
      for (var j = 3; j < 6; j++){
        tempRow.add(table[i][j]);
      }
      square.add(tempRow);
    }
    squares[1].add(square);
    return squares;
  }

  List<List<int>> convertS2T(List<List<List<List<int>>>> square){
    List<List<int>> table=[];
    print('convertS2T');
    print(square);
    for(var i =0;i<3;i++){

      table.add(square[0][0][i]+square[0][1][i]);
    }
    for(var i =0;i<3;i++){
      table.add(square[1][0][i]+square[1][1][i]);
    }
    print(table);
    return table;
    
  }

  List<int> convertIndexS2T(int cS,int rS,int cC,int rC){
    // 7 = 0,1,1,1 6*1+1+3*1+18*1
    int indexT=3*cS+18*rS+6*rC+cC;
    return [indexT%6,(indexT~/6)];


  }

  int checkEnd(List<List<int>> matrix_table){
    
    
    
    for(var s=0;s<2;s++){
      var check=2*s-1;
      var count=0;
      //row checking
      for(var i=0;i<matrix_table.length;i++){
        count=0;
        for(var j=0;j<matrix_table[i].length;j++){
          if(check==matrix_table[i][j]){
            count++;
            if(count==5){
            return check;
          }
          }
          else{
            count=0;
          }
        }
      }
      //column checking
      for(var i=0;i<6;i++){
        count=0;
        for(var j=0;j<6;j++){
          if(check==matrix_table[j][i]){
            count++;
            if(count==5){
            return check;
          }
          }
          else{
            count=0;
          }
        }
      }
      // dinagnal checking
      var rs=0;
      var cs=0;
      count=0;
      for(var i=0;i<6;i++){
        if(check==matrix_table[rs+i][cs+i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      }
      rs=1;
      cs=0;
      count=0;
      for(var i=0;i<5;i++){
        if(check==matrix_table[rs+i][cs+i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      }
      rs=0;
      cs=1;
      count=0;
      for(var i=0;i<5;i++){
        if(check==matrix_table[rs+i][cs+i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      }
      //
      rs=0;
      cs=5;
      count=0;
      for(var i=0;i<6;i++){
        if(check==matrix_table[rs+i][cs-i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      }
      rs=0;
      cs=4;
      count=0;
      for(var i=0;i<5;i++){
        if(check==matrix_table[rs+i][cs-i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      }
      rs=1;
      cs=5;
      count=0;
      for(var i=0;i<5;i++){
        if(check==matrix_table[rs+i][cs-i]){
          count++;
          if(count==5){
            return check;
          }
        }
        else{
          count=0;
        }
      } 
    }
    return 0;

  }

  List<List<int>> rotateSquare(List<List<int>>  square,bool clockwise){
    // [0,1,2]
    // [3,4,5]
    // [6,7,8]
    // [0,1],[1,2],[2,5],[5,8],[8,7],[7,6],[6,3],[3,0]
    // [0,2,8,6],[1,5,7,3]
    // [1, 0, -1, 1, 1, -1, 1, 0, -1]
    // [1, 0, -1, 0, 1, -1, 1, 0, -1]
    if (clockwise){
      List<int> swaps1=[0,2,8,6];
      List<int> swaps2=[1,5,7,3];
      
      List<int> flatternMatrix=[];
      print('rotateSquare');
      
      for(var i=0;i<square.length;i++){
        for(var j=0;j<square[i].length;j++){
            flatternMatrix.add(square[i][j]);
        }
      }
      print(flatternMatrix);
      int tempvalue=flatternMatrix[swaps1[0]];
      int temp=swaps1[0];
      for(var i=swaps1.length-1;i>=0;i--){
        if(i==0){
          flatternMatrix[temp]=tempvalue;
        }
        else{
          flatternMatrix[temp]=flatternMatrix[swaps1[i]];
          temp=swaps1[i];
        }
      }
      tempvalue=flatternMatrix[swaps2[0]];
      temp=swaps2[0];
      for(var i=swaps2.length-1;i>=0;i--){
        if(i==0){
          flatternMatrix[temp]=tempvalue;
        }
        else{
          flatternMatrix[temp]=flatternMatrix[swaps2[i]];
          temp=swaps2[i];
        }
      }
      print(flatternMatrix);
      
      List<List<int>> rotatedMatrix=[];
      List<int> temparray=[];
      for(var i=0;i<flatternMatrix.length;i++){
        temparray.add(flatternMatrix[i]);
        if((i+1)%3==0){
          rotatedMatrix.add(temparray);
          temparray=[];
        }
        
      }
      return rotatedMatrix;
    }
    // TODO un clockwised
    return [[]];
    
  }



  Widget cellUI(int color,int row,int column){
    Color? board =Colors.brown[200];
    Color? black =Colors.black;
    Color? white =Colors.white;
    Color? inside;
    switch(color){
        case 0:
          inside=board;
          break;
        case 1:
          inside=white;
          break;
        case -1:
          inside=black;
          break;
    };
    return GestureDetector(
      child:Container(
        margin: const EdgeInsets.all(10.0),
        color: board,
        width: 48.0,
        height: 48.0,
        child: new Container(
          margin: const EdgeInsets.all(6.0),
          width: 18.0,
          height: 18.0,
          decoration: new BoxDecoration(
            color: inside,
            shape: BoxShape.circle,
          ),
        )
      ),
      onTap:state==1?null:(){
        if(matrix_table[row][column]==0 ){
          setState(
            (){

                matrix_table[row][column]=turn;
                state=1;

            }

          );
        }
      },
    );



  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // print(convertT2S(matrix_table));
    // for(var i=0;i<2;i++){
    //   for(var j=0;j<2;j++){
    //     for(var s=0;s<3;s++){
    //       for(var k=0;k<3;k++){
    //         convertIndexS2T(i,j,k,s);
    //       }
    //     }
    //   }
    // }
    // X X
    // X X


    // Widget Matrixshow = Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: matrix_table.asMap().entries.map((row)=>(
    //     new Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: row.value.asMap().entries.map((element)=>(
    //         // new Text('$element')
    //         cellUI(element.value,row.key,element.key)
    //         ) as Widget).toList()
    //     )
    //       ) as Widget).toList(),
    // );
    List<List<List<List<int>>>> matrix_square=convertT2S(matrix_table);
    // print(matrix_square[0][0]);
    // print(rotateSquare(matrix_square[0][0],true));
    print(state); 
    print('checkEnd');
    winner=checkEnd(matrix_table);
    if(winner!=0){
      state=-1;
    }
    // [[[[0,0,0],[0,0,0],[0,0,0]]]]
    // column
    // row
    // coloumn
    // row
    //  0 1 2 3 4 5
    //  6 7 8 9 10 11
    //  12 13 14 
    // 
    // 
    // 7 = 0,1,1,1 6*1+1+3*1+18*1
    //
    Widget Matrixshow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: matrix_square.asMap().entries.map((row_square)=>(
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row_square.value.asMap().entries.map((column_square)=>(
            GestureDetector(
              child:Container(
                color: Colors.blue[200],
                margin:const EdgeInsets.all(2.0),
                child:new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:column_square.value.asMap().entries.map((row_cell)=>(
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:row_cell.value.asMap().entries.map((column_cell)=>
                      cellUI(column_cell.value,convertIndexS2T(row_square.key,column_square.key,row_cell.key,column_cell.key)[0],convertIndexS2T(row_square.key,column_square.key,row_cell.key,column_cell.key)[1])
                      as Widget).toList()
                    )
                  )as Widget).toList()
                )
              ),
              onTap:state==0?null:(){
                print('here');
                
                matrix_square[row_square.key][column_square.key]=rotateSquare(matrix_square[row_square.key][column_square.key],true);
                
                matrix_table=convertS2T(matrix_square);
                state=0;
                turn=-1*turn;
                setState((){});
              }
              )

          )as Widget).toList()
        )
          ) as Widget).toList(),
    );
    


    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Winner:',
            ),
            Text(
              '$winner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Matrixshow,
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
