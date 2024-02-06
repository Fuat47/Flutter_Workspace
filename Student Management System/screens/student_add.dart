import 'package:flutter/cupertino.dart';
import  'package:flutter/material.dart';
import 'package:kurulum/models/student.dart';

import '../validation/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;

  StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State<StudentAdd> with StudentValidationMixin {
  List<Student> students;
  var formKey = GlobalKey<FormState>();
  var student = Student.withoutInfo();
  _StudentAddState(this.students);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Student"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Student Name", hintText: "Ali"),
      validator: validateFirstName,
        onSaved: (String? value) {
        student.firstName = value!;
      },
    );
  }

  buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Student Lastname", hintText: "Yeşilöz"),
      validator: validateLastName,
      onSaved: (String? value) {
        student.lastName = value!;
      },
    );
  }

  buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Grade", hintText: "65"),
      validator: validateGrade,

      onSaved: (String? value) {
        student.grade = int.parse(value!);
      },
    );
  }

  buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!. validate()) {

          formKey.currentState!.save();


          Navigator.pop(context);
            students.add(student);



        }
      },
      child: Text('Add'),
    );
  }
}
