import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/sqlhelper.dart';

class HomPage extends StatefulWidget {
  const HomPage({super.key});

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  final _todoController = TextEditingController();
  List<Map<String, dynamic>> _foundToDo = [];
  List<Map<String, dynamic>> listofmap = [];

  void _refreshTodo() async {
    final data = await SQLHelper.getItems();
    setState(() {
      listofmap = data;
    });
  }

  void addText(int isdone) async {
    await SQLHelper.createItem(isdone, _todoController.text.trim());
    _refreshTodo();
  }

  void deleteText(int id) async {
    await SQLHelper.deleteItem(id);
    _refreshTodo();
  }

  void UpdateItem(int id, int isdone) async {
    await SQLHelper.updateItem(id, isdone);
    _refreshTodo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              // searchBox(),
              Expanded(
                child: Column(
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.only(
                    //     top: 50,
                    //     bottom: 20,
                    //   ),
                    //   child: const Text(
                    //     'All ToDo\'s',
                    //     style: TextStyle(
                    //         fontSize: 30, fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listofmap.length,
                          itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListTile(
                                onTap: () {
                                  listofmap[index]['isdone'] == 0
                                      ? UpdateItem(listofmap[index]['id'], 1)
                                      : UpdateItem(listofmap[index]['id'], 0);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                tileColor: Colors.white,
                                leading: Icon(
                                  (listofmap[index]['isdone'] == 0
                                          ? false
                                          : true)
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: tdBlue,
                                ),
                                title: Text(
                                  listofmap[index]['description'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: tdBlack,
                                      decoration:
                                          (listofmap[index]['isdone'] == 0
                                                  ? false
                                                  : true)
                                              ? TextDecoration.lineThrough
                                              : null),
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: tdRed,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: IconButton(
                                    color: Colors.white,
                                    iconSize: 18,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      //call on delete
                                      deleteText(listofmap[index]['id']);
                                    },
                                  ),
                                ),
                              ))),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      // _addToDoItem(_todoController.text);
                      addText(0);
                      _todoController.text = "";
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue, minimumSize: Size(60, 60)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runFilter(String enterKeyword) async {
    final data = await SQLHelper.getItems();
    setState(() {
      listofmap = data;
    });
    List<Map<String, dynamic>> results = [];
    if (enterKeyword.isEmpty) {
      results = listofmap;
    } else {
      // results = listofmap
      //     .where((element) => element
      //         .(listofmap[0]['description']).toString()
      //         .toLowerCase()
      //         .contains(enterKeyword.toLowerCase()))
      //     .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  // Widget searchBox() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //         color: Colors.white, borderRadius: BorderRadius.circular(20)),
  //     child: TextField(
  //       onChanged: (value) => _runFilter(value),
  //       decoration: const InputDecoration(
  //           contentPadding: EdgeInsets.all(0),
  //           prefixIcon: Icon(
  //             Icons.search,
  //             color: tdBlack,
  //             size: 20,
  //           ),
  //           prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
  //           border: InputBorder.none,
  //           hintText: 'search',
  //           hintStyle: TextStyle(color: tdGrey)),
  //     ),
  //   );
  // }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        const Text('All ToDo\'s',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/avatar.png")),
        )
      ]),
      centerTitle: true,
    );
  }
}
