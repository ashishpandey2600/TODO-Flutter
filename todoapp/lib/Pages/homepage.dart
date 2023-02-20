import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoapp/Pages/liststudentpage.dart';

import 'AddStudentPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Todo App"),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(),
                  ),
                ),
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 20.0),
              ),
              style: ElevatedButton.styleFrom(primary:
               Colors.deepPurple),
            ),
            
          ],
        ),
      ),

      body: ListStudent(),

      drawer: Drawer(child: Text("Ashihs pandey")),
      
    );
  }
}
