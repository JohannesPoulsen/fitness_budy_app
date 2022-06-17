import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/main.dart';
import 'package:fitness_body_app/model/app_master.dart';

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
    TextEditingController nameTextController =
        TextEditingController(text: widget.master.currentUser.name);
    TextEditingController emailTextController =
        TextEditingController(text: widget.master.currentUser.email);
    TextEditingController twitterTextController =
        TextEditingController(text: widget.master.currentUser.twitter);
    TextEditingController instagramTextController =
        TextEditingController(text: widget.master.currentUser.instagram);
    TextEditingController spotifyTextController =
        TextEditingController(text: widget.master.currentUser.spotify);
    TextEditingController facebookTextController =
        TextEditingController(text: widget.master.currentUser.facebook);
    TextEditingController ppTextController =
        TextEditingController(text: widget.master.currentUser.profileImagePath);
    TextEditingController cpTextController =
        TextEditingController(text: widget.master.currentUser.coverImagePath);

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
              onPressed: () {
                widget.master.currentUser.name = nameTextController.text;
                widget.master.currentUser.email = emailTextController.text;
                widget.master.currentUser.twitter = twitterTextController.text;
                widget.master.currentUser.instagram =
                    instagramTextController.text;
                widget.master.currentUser.spotify = spotifyTextController.text;
                widget.master.currentUser.facebook =
                    facebookTextController.text;
                widget.master.currentUser.profileImagePath =
                    ppTextController.text;
                widget.master.currentUser.coverImagePath =
                    cpTextController.text;

                updateProfile();
                Navigator.pop(context);
              },
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
              onProfileClicked: () {
                changeImageDialog(
                  textController: ppTextController,
                  labelText: "Profile Image URL",
                );
              },
              onCoverClicked: () {
                changeImageDialog(
                  textController: cpTextController,
                  labelText: "Cover Image URL",
                );
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Name",
                    textController: nameTextController,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Email",
                    textController: emailTextController,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Twitter link",
                    textController: twitterTextController,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Instagram link",
                    textController: instagramTextController,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Spotify link",
                    textController: spotifyTextController,
                  ),
                  SizedBox(height: 24),
                  profileTextField(
                    labelText: "Facebook link",
                    textController: facebookTextController,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future updateProfile() async {
    final userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.master.currentUser.email);

    await userDocument.set(widget.master.currentUser.toJson());
  }

  Widget profileTextField(
          {required String labelText,
          required TextEditingController textController}) =>
      TextField(
        controller: textController,
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

  Future changeImageDialog({
    required TextEditingController textController,
    required String labelText,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: profileTextField(
                  labelText: labelText,
                  textController: textController,
                ),
              ),
            ),
          ],
        );
      },
    );
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
              child: buildEditIcon(func: onProfileClicked),
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
            child: buildEditIcon(func: onCoverClicked),
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

  Widget buildEditIcon({required VoidCallback func}) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.red,
          all: 4,
          child: IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 20,
            ),
            tooltip: 'Edit Image',
            color: Colors.white,
            onPressed: () {
              func();
            },
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
