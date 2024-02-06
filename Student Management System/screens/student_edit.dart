import 'package:flutter/cupertino.dart';
import  'package:flutter/material.dart';
import 'package:kurulum/models/student.dart';

import '../validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student selectedStudent;

  StudentEdit(this.selectedStudent);

  @override
  State<StatefulWidget> createState() {
    return _StudentEditState(selectedStudent);
  }
}

class _StudentEditState extends State with StudentValidationMixin {
  Student selectedStudent;
  var formKey = GlobalKey<FormState>();
  _StudentEditState(this.selectedStudent);
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
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Student Name", hintText: "Ali"),
      validator: validateFirstName,
      onSaved: (String? value) {
        selectedStudent.firstName = value!;
      },
    );
  }

  buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Student Lastname", hintText: "Yeşilöz"),
      validator: validateLastName,
      onSaved: (String? value) {
        selectedStudent.lastName = value!;
      },
    );
  }

  buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Grade", hintText: "65"),
      validator: validateGrade,

      onSaved: (String? value) {
        selectedStudent.grade = int.parse(value!);
      },
    );
  }

  buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!. validate()) {

          formKey.currentState!.save();


          Navigator.pop(context);



        }
      },
      child: Text('Add'),
    );
  }
}
