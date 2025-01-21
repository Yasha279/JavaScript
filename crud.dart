import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuiCrud extends StatefulWidget {
  GuiCrud({super.key});

  @override
  State<GuiCrud> createState() => _GuiCrudState();
}

TextEditingController name = TextEditingController();
TextEditingController age = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController searchController = TextEditingController(); // For search

class _GuiCrudState extends State<GuiCrud> {
  List<Map<String, dynamic>> user = [
    {"Name": "Kirti", "Age": 18, "phone": 1234567889},
    {"Name": "John", "Age": 22, "phone": 9876543210},
    {"Name": "Emma", "Age": 25, "phone": 1122334455},
    {"Name": "Alex", "Age": 30, "phone": 5566778899},
  ];

  List<Map<String, dynamic>> filteredUser = []; // To store filtered results

  @override
  void initState() {
    super.initState();
    filteredUser = user; // Initially show all users
    searchController.addListener(_filterSearchResults);
  }

  void _filterSearchResults() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredUser = user.where((userItem) {
        // Check if the query matches any field (Name, Age, or Phone)
        return userItem['Name'].toLowerCase().contains(query) ||
            userItem['Age'].toString().contains(query) ||
            userItem['phone'].toString().contains(query);
      }).toList();
    });
  }

  void edit(int index) {
    name.text = filteredUser[index]["Name"];
    age.text = filteredUser[index]["Age"].toString();
    phone.text = filteredUser[index]["phone"].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: age,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your age",
                  labelText: "Age",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter your phone",
                  labelText: "Phone",
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    filteredUser[index] = {
                      "Name": name.text,
                      "Age": int.tryParse(age.text) ?? 0,
                      "phone": phone.text
                    };
                    user = filteredUser; // Update the main user list
                  });
                  Navigator.pop(context); // Close the dialog
                },
                child: Row(
                  children: [
                    Icon(Icons.save),
                    Text("Save Changes"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Crud GUI with Search',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name, Age or Phone',
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          // User input fields
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: "Enter your name",
              labelText: "Name",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your age",
              labelText: "Age",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Enter your phone",
              labelText: "Phone",
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                user.add({
                  "Name": name.text,
                  "Age": int.tryParse(age.text) ?? 0,
                  "phone": phone.text,
                });
                filteredUser.add({
                  "Name": name.text,
                  "Age": int.tryParse(age.text) ?? 0,
                  "phone": phone.text,
                });
              });
            },
            child: Row(
              children: [
                Icon(Icons.add_box),
                Text("Submit"),
              ],
            ),
          ),
          SizedBox(height: 10),
          filteredUser.isEmpty
              ? Expanded(
            child: Center(
              child: Text("No user found"),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: filteredUser.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      Icon(Icons.supervised_user_circle),
                      SizedBox(width: 20),
                      Text(
                        "Name: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(filteredUser[index]["Name"]),
                      SizedBox(width: 10),
                      Text(
                        "Age: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(filteredUser[index]["Age"].toString()),
                      SizedBox(width: 10),
                      Text(
                        "Phone: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(filteredUser[index]["phone"].toString()),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("edit"),
                              content: Text("are u sure"),
                              actions: [
                                TextButton(onPressed: () {

                                  Navigator.pop(context);
                                  edit(index);
                                  setState(() {

                                  });
                                }, child: Text("yes")),
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("no"))
                              ],
                            );
                          });
                        },
                        icon: Icon(Icons.edit_note),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                         showDialog(context: context, builder: (context) {
                           return CupertinoAlertDialog(
                             title: Text("delete"),
                             content: Text("are u sure"),
                             actions: [
                               TextButton(onPressed: () {
                                 user.removeAt(index);
                                 Navigator.pop(context);
                                 setState(() {

                                 });
                               }, child: Text("yes")),
                               TextButton(onPressed: () {
                                 Navigator.pop(context);
                               }, child: Text("no"))
                             ],
                           );
                         });
                          setState(() {



                          });

                        },
                        icon: Icon(Icons.delete_forever_rounded),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
