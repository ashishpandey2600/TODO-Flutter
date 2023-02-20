import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateStudentPage extends StatefulWidget {
  const UpdateStudentPage({super.key});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  updateUser() {
    print('User Update');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  initialValue: 'Ashish',
                  autofocus: false,
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'please Enter Name';
                    }
                    return null;
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  initialValue: 'Email@email.com',
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  validator: ((value) {
                    if (value == null || value == value.isEmpty) {
                      return 'please Enter Email';
                    } else if (value!.contains('@')) {
                      return 'please Enter Valid Email';
                    }
                    return null;
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  initialValue: '2312323',
                  obscureText: true,
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  validator: ((value) {
                    if (value == null || value == value.isEmpty) {
                      return 'please Enter Password';
                    }
                    return null;
                  }),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateUser();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(onPressed: ()=>{}, child: Text('Reset',
                    style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
