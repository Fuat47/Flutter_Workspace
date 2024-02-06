import 'package:flutter/material.dart';
import 'package:kurulum/models/student.dart';
import 'package:kurulum/screens/student_add.dart';
import 'package:kurulum/screens/student_edit.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      //debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> students = [
    Student.withId(1, "ali", "yesiloz", 45),
    Student.withId(2, "memo", "ysz", 95),
    Student.withId(3, "kerem", "biler", 25),
  ];
  Student selectedStudent = Student.withId(0, "HİC", "KİMSE", 0);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Deneme"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(students[index].firstName +
                      " " +
                      students[index].lastName),
                  subtitle: Text("Exam grade : " +
                      students[index].grade.toString() +
                      "[" +
                      students[index].getStatus +
                      "]"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.woolha.com/media/2020/03/eevee.png"),
                  ),
                  trailing: buildStatusIcon(students[index].grade),
                  onTap: () {
                    setState(() {
                      this.selectedStudent = students[index];
                    });
                  },
                  onLongPress: () {
                    print("uzun basıldı");
                  },
                );
              }),
        ),
        Text("Seçili öğrenci " + selectedStudent.firstName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni Öğrenci")
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentAdd(students as List<Student>)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black),
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Update")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black),
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil")
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var message = "Deleted : " + selectedStudent.firstName;
                  showMessage(context, message);

                  print("Sil");
                },
              ),
            )
          ],
        )
      ],
    );
  }

  void showMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text("Result"),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
