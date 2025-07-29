import 'package:flutter/material.dart';

import '../../widgets/customScaffoldWidget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF5D6EFF);
    final Color lightBlue = const Color(0xFF8A97FF);

    final profile = {
      "profileImageUrl": "assets/profile_icon.png",
      "firstname": "Test",
      "lastname": "user",
      "email": "testuser@example.com",
      "phoneNumber": "1234567890"
    };

    return CustomScaffoldWidget(
      isDrawerRequired: true,
      appbartitle: 'Profile',
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryBlue, lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage("${profile["profileImageUrl"]}"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profile["firstname"]} ${profile["lastname"]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          fontFamily: 'satoshi',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Employee ID:', "5435435"),
                const SizedBox(height: 10),
                _buildInfoRow('Address:', "PECHA Block 6 260-D"),
                const SizedBox(height: 10),
                _buildInfoRow('Phone:', "+925454343534"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _groupCard({
    required BuildContext context,
    required String title,
    required int memberCount,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 0.30,
      width: screenWidth * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.045,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: screenWidth * 0.10,
                width: screenWidth * 0.10,
                decoration: BoxDecoration(
                  color: const Color(0xffDBE4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Image.asset(
                    "assets/users-02.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black87,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            children: [
              Image.asset(
                "assets/framegroup.png",
                height: screenWidth * 0.1,
                width: screenWidth * 0.15,
                fit: BoxFit.contain,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                '$memberCount other doctors',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade900,
                  fontFamily: 'satoshi',
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 30),
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.grey.shade400,
                  size: screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
