import 'package:admin_panel/datasources/user_remote_datasources.dart';
import 'package:admin_panel/models/user_model.dart';
import 'package:admin_panel/views/screens/bookings/manage_bookings_screen.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final userViewmodel = UserRemoteDatasources();
  List<UserModel> fetchedUsers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    fetchedUsers = await userViewmodel.getUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Users"), centerTitle: true),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: fetchedUsers.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${fetchedUsers[index].firstName}"),
                        Text("Surname: ${fetchedUsers[index].lastName}"),
                        Text("Gender: ${fetchedUsers[index].gender}"),
                        Text("Email: ${fetchedUsers[index].login}"),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ManageBookingsScreen(
                                      bookings: fetchedUsers[index].bookings,
                                    ),
                              ),
                            );
                          },
                          child: Text("Bookings"),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
