import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Model/Master.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/localUser.dart';
import '../ViewController/profile.dart';
import 'package:fitness_body_app/ViewController/main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.master}) : super(key: key);
  final Master master;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final double coverHeight = 224.0;
  final double ppHeight = 120.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text("Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
              tooltip: "Save Changes",
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          children: [
            ProfileEditWidget(
              profileImagePath: widget.master.currentUser.profileImagePath,
              coverImagePath: widget.master.currentUser.coverImagePath,
              onProfileClicked: () {},
              onCoverClicked: () {},
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Name",
                    currText: widget.master.currentUser.name,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Email",
                    currText: widget.master.currentUser.email,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Twitter link",
                    currText: widget.master.currentUser.twitter ?? "",
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Instagram link",
                    currText: widget.master.currentUser.instagram ?? "",
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Spotify link",
                    currText: widget.master.currentUser.spotify ?? "",
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Facebook link",
                    currText: widget.master.currentUser.facebook ?? "",
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget profileTextField(
          {required String labelText, required String currText}) =>
      TextField(
        controller: TextEditingController(
          text: currText,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.grey),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.black),
              borderRadius: BorderRadius.circular(15)),
        ),
      );
}

class ProfileEditWidget extends StatelessWidget {
  final double ppHeight = 120.0;
  final double coverHeight = 224.0;
  final String profileImagePath;
  final String coverImagePath;
  final VoidCallback onProfileClicked;
  final VoidCallback onCoverClicked;

  const ProfileEditWidget(
      {Key? key,
      required this.profileImagePath,
      required this.coverImagePath,
      required this.onProfileClicked,
      required this.onCoverClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bottom = ppHeight / 2;
    final double top = coverHeight - ppHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(
            top: top,
            child: buildEditProfileImage(),
          ),
        ]);
  }

  Widget buildEditProfileImage() => Center(
        child: Stack(
          children: [
            buildProfileImagePicture(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(),
            ),
          ],
        ),
      );

  Widget buildCoverImage() => Stack(
        children: [
          buildCoverImagePicture(),
          Positioned(
            bottom: -1,
            right: 1,
            child: buildEditIcon(),
          ),
        ],
      );

  Widget buildProfileImagePicture() => CircleAvatar(
        radius: ppHeight / 2,
        backgroundColor: Colors.pinkAccent,
        backgroundImage: NetworkImage(profileImagePath),
      );

  Widget buildCoverImagePicture() => Container(
        color: Colors.grey[900],
        width: double.infinity,
        height: coverHeight,
        child: Image(
          image: NetworkImage(coverImagePath),
        ),
      );

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.red,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle(
          {required Widget child, required double all, required Color color}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
