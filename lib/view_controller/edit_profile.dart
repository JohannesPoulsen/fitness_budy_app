import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Model/Master.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/localUser.dart';
import '../ViewController/profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.master}) : super(key: key);
  final Master master;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //localUser user = widget.master.currentUser;
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
          ],
        ));
  }
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

  Widget buildCoverImage() => Container(
        color: Colors.grey[900],
        width: double.infinity,
        height: coverHeight,
        child: Image(
          image: NetworkImage(coverImagePath),
        ),
      );

  Widget buildProfileImagePicture() => CircleAvatar(
        radius: ppHeight / 2,
        backgroundColor: Colors.pinkAccent,
        backgroundImage: NetworkImage(profileImagePath),
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
