import 'package:flutter/material.dart';
import '../screens/create_user_profile.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({key}) : super(key: key);

  void _onTileClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewProfile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTileClicked(context),
      child: const ListTile(
        tileColor: Colors.green,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=826&t=st=1691602541~exp=1691603141~hmac=3f81e49f54c26d6fda82636b522f3ae4b32d73dae78b5800f42d4e264e666275'),
          radius: 15,
        ),
        title: Text(
          'Anupom Roy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'anupomhstu@gmail.com',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Center(
        child: Text('User Profile Screen'),
      ),
    );
  }
}
