import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Model/Master.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
    final String name = "Amogus Sus";
    final String email = "amogussus@sussymail.com";

    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          name,
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
          email,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        buildSocialIcons(),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.red,
        width: double.infinity,
        height: coverHeight,
        // fit: BoxFit.cover,
        child: Image.network(
            'https://www.charlottehaven.com/media/1119/healthclub_traaning-og-faciliteter_fitness_topslider1920x1080_01.jpg?anchor=center&mode=crop&width=1200&height=628&rnd=132785091678870000'),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: ppHeight / 2,
        backgroundColor: Colors.pinkAccent,
        backgroundImage: NetworkImage(
            'https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec'),
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
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(child: Icon(icon, size: 32)),
          ),
        ),
      );
}
