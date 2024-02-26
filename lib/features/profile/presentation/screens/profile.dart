//import 'package:admin/features/items/bloc/items_bloc.dart';
//import 'package:admin/features/items/bloc/items_states.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



   bool isLoding = false;
  // Future<void> logout() async {
  //   try {
  //     setState(() {
  //       isLoding = true;
  //     });
  //     await BlocProvider.of<ItemsBloc>(context)
  //         .repository
  //         .signOut()
  //         .then((value) {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const LoginScreenClient()));
  //       setState(() {
  //         isLoding = false;
  //       });
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoding = false;
  //     });
  //     //print('Logout failed: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage("assets/profile_avatar.jpg"),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: ClipOval(
                        child: Container(
                          color: Colors.amber,
                          child: IconButton(
                            onPressed: () {
                              // Your onPressed logic here
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "name",
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const Text(
                "emaik",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                onPressed: null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ListTile(
                onTap: null,
                leading: _buildLeadingIcon(
                    Icons.person, Colors.blue.withOpacity(0.1)),
                title: const Text("Profile"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: null,
                leading: _buildLeadingIcon(
                    Icons.settings, Colors.blue.withOpacity(0.1)),
                title: const Text("Settings"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: null,
                leading: _buildLeadingIcon(
                    Icons.history, Colors.blue.withOpacity(0.1)),
                title: const Text("History"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: null,
                leading: !isLoding
                    ? _buildLeadingIcon(
                        Icons.logout, Colors.blue.withOpacity(0.1))
                    : const CircularProgressIndicator(),
                title: GestureDetector(
                  onTap: (){},
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLeadingIcon(IconData icon, Color backgroundColor) {
  return Ink(
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: Colors.blue,
      ),
    ),
  );
}
