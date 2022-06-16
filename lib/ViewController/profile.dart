import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Model/Master.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.master}) : super(key: key);
  final Master master;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: const Text("Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final name = "testeste";

              testUpload(name: name);
            },
            icon: const Icon(Icons.edit),
            tooltip: "Edit Profile",
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
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
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          widget.master.currentUser.name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          widget.master.currentUser.email,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        buildSocialIcons(),
        const SizedBox(height: 16),
        buildSocialNumbers(
          workoutsAmount: widget.master.currentUser.amountOfPublicWorkouts,
          followingAmount: widget.master.currentUser.amountOfFollowing,
          followersAmount: widget.master.currentUser.amountOfFollowers,
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey[900],
        width: double.infinity,
        height: coverHeight,
        // fit: BoxFit.cover,
        //child: Image(
          //image: NetworkImage(widget.master.currentUser.coverImagePath),
        //),
      );

  Widget buildProfileImage() => Center(
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

  Widget buildProfileImagePicture() => CircleAvatar(
        radius: ppHeight / 2,
        backgroundColor: Colors.pinkAccent,
        backgroundImage: NetworkImage(
            "https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec") /*NetworkImage(widget.master.currentUser.profileImagePath)*/,
      );

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.red,
          all: 8,
          child: Icon(
            Icons.edit,
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

  Widget buildSocialIcons(
      {String? instagram = null,
      String? spotify = null,
      String? twitter = null,
      String? facebook = null}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialIcon(FontAwesomeIcons.twitter, twitter),
        const SizedBox(width: 12),
        buildSocialIcon(FontAwesomeIcons.instagram, instagram),
        const SizedBox(width: 12),
        buildSocialIcon(FontAwesomeIcons.spotify, spotify),
        const SizedBox(width: 12),
        buildSocialIcon(FontAwesomeIcons.facebook, facebook),
      ],
    );
  }

  Widget buildSocialIcon(IconData icon, String? link) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.red[300],
          child: InkWell(
            onTap: () {},
            child: Center(child: Icon(icon, size: 32, color: Colors.white)),
          ),
        ),
      );

  Future testUpload({required String name}) async {
    final testUser =
        FirebaseFirestore.instance.collection('test1').doc("test-id2");

    final data = {
      "name": name,
      "alder": 21,
      "lort": "testelel",
    };

    await testUser.set(data);
  }
}

class buildSocialNumbers extends StatelessWidget {
  const buildSocialNumbers(
      {required this.workoutsAmount,
      required this.followingAmount,
      required this.followersAmount});
  final int workoutsAmount;
  final int followingAmount;
  final int followersAmount;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildSocialButton(context, workoutsAmount, "Workouts"),
            buildSocialsDivider(),
            buildSocialButton(context, followingAmount, "Following"),
            buildSocialsDivider(),
            buildSocialButton(context, followersAmount, "Followers"),
          ],
        ),
      );

  Widget buildSocialsDivider() => Container(
        height: 24,
        child: VerticalDivider(color: Colors.black),
      );

  Widget buildSocialButton(BuildContext context, int value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
